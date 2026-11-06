# Preparação e reprodução manual

Este guia foi preparado para o repositório em 05/11/2026 a partir dos arquivos existentes. Não é um novo registro experimental e seus comandos de execução não foram executados no empacotamento. Conservar as evidências originais; uma repetição terá novos horários, tokens e possivelmente IDs.

## 1. Obter e conferir o material

```powershell
git clone https://github.com/jukagoncalves/tcc-finsim-security-context-card.git
Set-Location .\tcc-finsim-security-context-card
powershell -NoProfile -File .\scripts\verificar_integridade.ps1
```

## 2. Configurar cada ambiente

Na raiz do repositório:

```powershell
powershell -NoProfile -File .\scripts\inicializar_env.ps1 -Versao v1
powershell -NoProfile -File .\scripts\inicializar_env.ps1 -Versao v2
```

Os scripts criam segredos aleatórios, não mostram seus valores e recusam sobrescrever `.env` existente. Os `.env.example` documentam as quatro variáveis necessárias. Alterar o `.env` depois da inicialização não atualiza automaticamente as credenciais já gravadas no volume MySQL.

## 3. Iniciar somente o ambiente desejado

```powershell
Set-Location .\ambiente_finsim_v1
docker compose up -d --build
docker compose ps
Invoke-RestMethod -Uri 'http://127.0.0.1:5000/' -Method Get
```

Para v2, use a pasta `ambiente_finsim_v2` e a porta 5001. A resposta da rota inicial é `Hello, world! FinSim-Trans.`. Os serviços `api` e `db` devem ficar saudáveis antes da preparação dos dados. Isso verifica disponibilidade, não os cenários de autorização.

| Componente | Versão/configuração preservada |
|---|---|
| Python | Imagem `python:3.8.20-slim-bookworm` |
| MySQL | Imagem `mysql:8.0.27` |
| Flask | 1.1.4 |
| Flask-JWT-Extended | 3.25.1 |
| SQLAlchemy | 1.3.24 |
| Dependências completas | `requirements.txt` em cada ambiente |
| Compose v1 | Projeto `tcc-finsim-v1`, API `127.0.0.1:5000` |
| Compose v2 | Projeto `tcc-finsim-v2`, API `127.0.0.1:5001` |

Cada projeto possui seu próprio volume MySQL. **Se já existirem os projetos históricos com esses nomes no computador, os comandos padrão podem reutilizá-los.** Para uma reprodução nova, utilize nomes alternativos em TODOS os comandos, por exemplo `docker compose -p tcc-finsim-repro-v1 up -d --build`, e pare antes o ambiente que ocupar a mesma porta. Não use `down -v` nos ambientes de coleta: esse comando apaga o volume de dados.

As imagens estão identificadas por tags, não por digests de imagens coletadas. Portanto, a construção depende da disponibilidade dessas imagens e dos pacotes; o repositório não promete identidade binária de futuras reconstruções.

## 4. Preparar os dados sintéticos

Antes dos testes, ler `pacote_comum_v1/01_politicas.md` e `02_cenarios.md`. As regras de referência não devem ser substituídas pelo comportamento observado.

| Identidade | Nome de usuário | Papel | Ambiente |
|---|---|---|---|
| A | `tcc_usuario_a` | `USER` | v1 e v2 |
| B | `tcc_usuario_b` | `USER` | v1 e v2 |
| CC | `tcc_operador_cc` | `CC` | v1, para S3 |

Registrar por `POST /registration` com os campos `username`, `password` e `role`; escolher senhas sintéticas locais. Autenticar por `POST /login` com `username` e `password`. Usar o `access_token` retornado no cabeçalho `Authorization: Bearer <token>`, sem salvar tokens nas evidências destinadas à publicação. Renovar a autenticação se o token expirar.

Autenticado como B, criar sua conta por `POST /account/create` com:

```json
{"number":"2000000000000002"}
```

Confirmar a existência da conta, saldo inicial zero e histórico vazio consultando como B:

- `GET /web/account?number=2000000000000002`
- `GET /web/transactions?number=2000000000000002`

Registrar os IDs observados. Não presumir os IDs históricos em um banco reaproveitado. Para S3, confirmar que `3000000000000003` não existe antes da tentativa.

## 5. Executar manualmente e registrar

Salvar cada repetição em uma pasta nova, fora de `evidencias/`, com versão, data, executor, método, URI, corpo, status HTTP, resposta e estados antes/depois. Preservar também falhas HTTP; elas são parte da observação. As evidências publicadas contêm modelos de registro.

| Cenário | Solicitação | Oráculo de referência |
|---|---|---|
| S1/v1 | A consulta `GET /web/account?number=2000000000000002` | Impedir obtenção dos dados de B e preservar estado observado |
| S2/v1 e S2/v2 | A solicita `POST /bank/deposit` com o JSON abaixo | Rejeitar identidade declarada diferente de A, sem alterar saldo ou persistir depósito |
| S3/v1 | CC solicita `POST /account/create` com `{"number":"3000000000000003"}` | Negar criação pelo papel CC, sem nova conta nem alteração de contas existentes |

Corpo de S2:

```json
{"amount":"10.00","account":"2000000000000002","counterpart_name":"tcc_usuario_b"}
```

Em S1 e S2, consultar conta e histórico como B antes e depois. Em S3, capturar a lista completa de contas diretamente no banco antes/depois; a listagem restrita ao usuário não demonstra o estado global. Exemplo de leitura na pasta do ambiente v1:

```powershell
docker compose exec -T api python -c "import json; from finsim_trans import app; from finsim_trans.models import AccountModel; ctx=app.app_context(); ctx.push(); print(json.dumps([dict(id=a.id,account_number=a.account_number,balance=str(a.balance),owner_id=a.owner_id) for a in AccountModel.query.order_by(AccountModel.id).all()],indent=2)); ctx.pop()"
```

Para reproduzir a sequência histórica da v1, preparar A/B e conta de B, realizar S1, realizar S2 e depois preparar/autenticar CC e realizar S3. Na v2, preparar A/B e conta de B em banco independente e realizar somente S2. Uma repetição de S2/v2 pode elevar o saldo novamente; uma repetição de S3 com o mesmo número deixa de satisfazer a precondição de número não utilizado. Não reutilizar esses estados como se fossem os estados iniciais.

A correção de v2 está documentada em `CORRECAO_TECNICA_S2.md`: extrair `['username']` da identidade JWT na busca do usuário. Ela não acrescenta a regra de autorização. Não substituir a execução inconclusiva da v1 pelo resultado da v2.

## 6. Encerrar e retomar

Na pasta do ambiente (ou usando o mesmo `-p` adotado):

```powershell
docker compose stop
```

Isso preserva o volume. Para retomar:

```powershell
docker compose start
docker compose ps
```

Faça novo login para obter tokens válidos. As senhas de configuração, volumes e novas execuções ficam somente no computador local.
