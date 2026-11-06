# Cenários de entrada do estudo

Situação: cenários revisados e adotados no estudo. Estes são dados de entrada e expectativas, não resultados executados nem listas derivadas C0/C1.

## S1 — Consulta de conta de outro usuário

| Campo | Definição |
|---|---|
| Executor | A, autenticado com papel USER e token válido |
| Objeto | Conta existente pertencente a B |
| Operação | GET /web/account, informando number da conta de B |
| Precondições | A e B existem e são distintos; ambos USER; conta de B existente e propriedade conferida; token de A válido; entrada válida |
| Resultado esperado | Não divulgar a A os dados protegidos da conta de B |
| Efeito no estado | Conta de B e demais registros financeiros inalterados |
| Política | P1 |
| Evidências | E1 e E2; E6 para identidade e rota |
| Observação prevista | Resposta completa; comparação das contas e registros financeiros antes/depois em ambiente isolado |

## S2 — Depósito com identidade declarada divergente

| Campo | Definição |
|---|---|
| Executor | A, autenticado com papel USER e token válido |
| Objeto | Conta existente pertencente a B |
| Operação | POST /bank/deposit; account aponta para a conta de B, counterpart_name contém o username de B e amount é positivo |
| Precondições | A e B existem e são distintos; ambos USER; saldo inicial de B conhecido; token de A válido; valores e campos válidos; B não é o username de A |
| Resultado esperado | Rejeitar a divergência: o token identifica A, mas o iniciador declarado é B |
| Efeito no estado | Saldo de B inalterado; nenhuma transação financeira de depósito persistida; contas existentes inalteradas |
| Política | P2 |
| Evidências | E3 e E4; E6 para identidade e rota |
| Observação prevista | Resposta; estado das contas e registros de transações antes/depois; counterpart_name caso haja persistência inesperada |

counterpart_acct é opcional; sua utilização deve ser fixada no protocolo e mantida nas duas condições. Não há necessidade de inventar conta de origem: o método inspecionado credita uma conta e não apresenta débito de origem. O comportamento com ausência de token pode ser uma verificação preparatória, mas não substitui este cenário com A autenticado e não constitui um quarto cenário aprovado.

## S3 — Criação de conta por papel não autorizado

| Campo | Definição |
|---|---|
| Executor | Identidade autenticada com papel CC e token válido |
| Objeto | Nova conta com número válido e ainda não utilizado |
| Operação | POST /account/create, informando number |
| Precondições | Executor CC existe e seu papel foi conferido; token válido; número novo; entrada válida; estado inicial das contas registrado |
| Resultado esperado | Negar a criação por falta de autorização |
| Efeito no estado | Nenhuma conta nova persistida; contas existentes inalteradas |
| Política | P3 |
| Evidências | E5 e E6 |
| Observação prevista | Resposta; ausência de conta com o número solicitado e comparação das contas antes/depois |

## Dados concretos ainda a preparar

Usernames, credenciais, identificadores, números das contas, saldo inicial e valor positivo do depósito não foram fixados nem criados neste pacote. Devem ser definidos antes da execução, com dados sintéticos, ausência de operações concorrentes e estado inicial restaurável. A conta de B existe em S1/S2; a conta solicitada em S3 não existe.
