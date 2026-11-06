# TCC — FinSim e Security Context-Card

Material de apoio ao TCC de Juka e Maria Júlia sobre requisitos de teste de autorização em uma versão reduzida da FinSim. O repositório reúne os ambientes Docker utilizados, os materiais de derivação C0/C1, as evidências preservadas, as avaliações GQM.

## Comece por aqui

- [Como preparar e reproduzir o ambiente](docs/REPRODUCAO.md)
- [Índice das evidências e dos resultados vigentes](docs/INDICE_EVIDENCIAS.md)
- [Proveniência, integridade e limites do pacote](docs/PROVENIENCIA.md)

Os resultados são históricos. Publicar este repositório não representa uma nova execução dos cenários. Os arquivos originais foram copiados sem alteração de conteúdo; documentação e utilitários de publicação foram acrescentados em 05/11/2026 com assistência de IA e devem ser distinguidos dos registros da coleta.

## Organização

| Caminho | Conteúdo |
|---|---|
| `ambiente_finsim_v1/` | Código, configuração Docker, baseline, adaptações e evidências de S1/S2/S3 |
| `ambiente_finsim_v2/` | Ambiente separado com correção técnica do depósito e execução complementar de S2 |
| `pacote_comum_v1/` | Políticas, cenários, interface, dados e evidências de código |
| `preparacao_c0_c1_v1/` | Duas apresentações do mesmo conteúdo e correspondência entre blocos |
| Arquivos `.md` na raiz | Procedimento, fichas, rastreabilidade, consenso e consolidações GQM |
| `scripts/` | Geração de credenciais locais e verificação de integridade, sem execução de cenários |
| `docs/` | Guias de publicação, catálogo e manifesto SHA-256 |
| `terceiros/` | README original do FinSim e atribuição de origem |

**C0/C1 são condições de apresentação das informações; v1/v2 são versões do ambiente.** As evidências de execução são compartilhadas entre requisitos equivalentes de C0 e C1; não constituem dois grupos independentes de testes.

## Resultados documentados

| Cenário | Ambiente | Observação | Classificação no recorte do estudo |
|---|---|---|---|
| S1 — consulta de conta de B por A | v1 | HTTP 200 com campos nulos; saldo e histórico consultados inalterados | Correspondente no caso observado |
| S2 — depósito com identidade declarada divergente | v1 | HTTP 500; saldo e histórico inalterados | Inconclusiva por impedimento técnico |
| S2 — execução complementar | v2 | HTTP 200; saldo de 0,00 para 10,00 e crédito com `counterpart_name` de B | Divergente da política adotada |
| S3 — criação de conta por CC | v1 | HTTP 200 e nova conta persistida | Divergente da política adotada |

Em v1, as três execuções incluídas resultaram em uma correspondente, uma divergente e uma inconclusiva. A primeira tentativa de S1 foi excluída das contagens e permanece apenas no histórico. A execução de S2 em v2 não substitui a tentativa em v1.

Os requisitos finais de C0/C1 tiveram média M1 = 5,00, M2 = 100% e M3 = 2/3 na base comum v1. As diferenças descritivas de M5 foram zero. O conhecimento prévio, a elaboração sequencial, a assistência de IA, a revisão conjunta e as evidências compartilhadas impedem isolar o efeito do Card ou concluir equivalência geral entre as condições.

## Execução local

Requisitos: Git, Docker com Compose v2 e PowerShell. Obtenha a cópia pública:

```powershell
git clone https://github.com/jukagoncalves/tcc-finsim-security-context-card.git
Set-Location .\tcc-finsim-security-context-card
powershell -NoProfile -File .\scripts\verificar_integridade.ps1
```

Em um computador sem os projetos históricos `tcc-finsim-v1` e `tcc-finsim-v2`, prepare e inicie a v1 com os comandos abaixo. Se esses projetos já existirem, consulte a seção 3 do [guia de reprodução](docs/REPRODUCAO.md) para usar nomes separados e preservar os dados de coleta.

```powershell
powershell -NoProfile -File .\scripts\inicializar_env.ps1 -Versao v1
Set-Location .mbiente_finsim_v1
docker compose up -d --build
docker compose ps
```

A API v1 utiliza `http://127.0.0.1:5000`; v2 utiliza `http://127.0.0.1:5001` e exige seu próprio `.env`. A inicialização cria tabelas, mas não repõe os usuários, contas ou transações históricos. Siga o [guia de reprodução](docs/REPRODUCAO.md) antes de preparar dados ou executar cenários.

O ambiente contém os comportamentos de autorização estudados e destina-se exclusivamente a laboratório local com dados sintéticos. Mantenha as portas vinculadas a `127.0.0.1`. As dependências históricas foram preservadas; não são uma recomendação de configuração para produção.

## Credenciais e dados

Os `.env` originais, tokens e volumes Docker não são publicados. Cada pessoa gera suas próprias credenciais locais. O repositório contém estados observados em JSON, não uma cópia do volume MySQL. Novas execuções devem ser salvas fora das pastas históricas, por exemplo em `novas_execucoes/`, que está ignorada pelo Git.

## Origem do software

O componente bancário deriva de [cmu-sei/finsim](https://github.com/cmu-sei/finsim), da Carnegie Mellon University / Software Engineering Institute. Os avisos de autoria foram preservados. Consulte [as notas de terceiros](terceiros/README.md). Não foi atribuída uma licença nova ao conjunto da monografia, evidências e materiais de terceiros.
