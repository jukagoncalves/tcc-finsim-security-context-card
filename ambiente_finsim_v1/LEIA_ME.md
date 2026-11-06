# Ambiente reduzido FinSim — preparação inicial

## Etapa atual

O banco foi iniciado pelos pesquisadores e informado como saudável. A API finsim-trans foi acrescentada à configuração para construção e inicialização pelos pesquisadores. Não foram criados os usuários sintéticos A/B/CC, contas ou transações e não foram executados cenários experimentais.

Este projeto tem nome `tcc-finsim-v1`, banco `trans` e volume próprio `trans_data` com prefixo do projeto. Não utiliza o banco WordPress do projeto `compose`. A porta do banco não é publicada no Windows; o acesso posterior da API ocorrerá pela rede interna do Compose, usando o nome `db`.

O arquivo .env contém credenciais locais geradas para este ambiente. Não é dado de pesquisa nem precisa ser publicado. Não use credenciais pessoais. O usuário MySQL `trans` é uma credencial de infraestrutura, diferente dos usuários A/B da aplicação financeira.

## Versão e adaptação a documentar

Este arquivo utiliza mysql:8.0.27, a versão observada no ambiente Docker existente. O README original do FinSim menciona MySQL 5.7. A escolha de 8.0.27 é uma configuração de preparação que ainda requer verificação de compatibilidade com a API; não foi confirmada equivalência experimental. Antes da coleta, registrar a versão efetivamente adotada, identificação da imagem e eventuais ajustes. Este ambiente destina-se apenas ao estudo local com dados sintéticos.

## Primeiro passo a executar pelos pesquisadores

No PowerShell:

```powershell
Set-Location -LiteralPath 'C:\Users\Steel Legend\Documents\Vida Academica\TCC\ambiente_finsim_v1'
docker compose up -d db
docker compose ps
```

O primeiro comando seleciona a pasta. O segundo cria e inicia o serviço de banco e seu volume; o Docker poderá baixar a imagem se necessário. O terceiro mostra o estado. Aguarde a indicação `healthy`; inicialização pode levar algum tempo. Repita somente `docker compose ps` para conferir.

Se o serviço não iniciar, consulte:

```powershell
docker compose logs --tail 60 db
```

Envie o estado ou erro para orientar o próximo passo. Banco saudável confirma apenas preparação do serviço, não executabilidade de requisitos ou atendimento de políticas de autorização.

## Próximos passos

Preparar uma cópia identificada do componente finsim-trans, definir dependências compatíveis, configurar conexão e registrar adaptações. Depois verificar inicialização da API. Preparação de dados sintéticos e execução dos cenários serão atividades posteriores, com registros próprios.

Não executar clear_tables.sql do repositório nesta fase. Para interromper este ambiente sem remover os dados, use `docker compose stop`. Alterar credenciais no .env depois de inicializar o volume não altera automaticamente as credenciais já gravadas no banco.


## Segundo passo — iniciar a API (23/10/2026)

Nesta mesma pasta, executar:

```powershell
docker compose up -d --build api
docker compose ps
```

A construção baixa uma imagem Python e instala as dependências fixadas. Pode levar vários minutos. Se falhar, preservar a mensagem e enviar o erro antes de alterar versões. `pip check` verifica consistência declarada das dependências, mas não comprova comportamento funcional.

Quando o serviço api estiver saudável, conferir somente a página inicial:

```powershell
Invoke-RestMethod -Uri 'http://127.0.0.1:5000/' -Method Get
```

Resposta esperada para esta verificação de disponibilidade: `message` com `Hello, world! FinSim-Trans.`. Isso não é um teste de S1, S2 ou S3 e não conta como dado de M3/M4. O healthcheck também consulta essa rota. O gancho original before_first_request cria as tabelas ausentes no banco, sem inserir usuários ou transações.

Se o serviço api não ficar saudável:

```powershell
docker compose logs --tail 80 api
```

Enviar o estado/erro para orientação. Não executar cadastro, depósito ou criação de conta ainda. Ver ADAPTACOES_API.md para as mudanças da cópia de trabalho.
