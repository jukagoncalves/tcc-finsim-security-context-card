# Interface e dados relevantes

Descrição estática da cópia local; não é documentação de uma instância já funcional.

## Operações

| Método e rota | Entradas | Identidade e comportamento observados |
|---|---|---|
| POST /login | username, password | Verifica credenciais; constrói identidade com username e role; emite tokens |
| GET /web/account | number | Exige token; verifica propriedade; dados de saída definidos como id, account_number e balance |
| POST /bank/deposit | amount, account, counterpart_name; counterpart_acct opcional | Exige token; copia contraparte da solicitação para transação; não há comparação explícita com username do token no método |
| POST /account/create | number | Exige token; define proprietário a partir de identity['username']; não há condição de autorização por papel |
| GET /web/transactions | number | Exige token e propriedade; disponibiliza registros da conta, incluindo contraparte |

O mecanismo exato de envio dos argumentos GET, o formato das respostas e os códigos HTTP devem ser conferidos com as versões efetivamente utilizadas. Não são fixados por este pacote. /registration existe e aceita username, password e role, mas sua segurança não integra os três cenários.

## Identidades e papéis

| Papel | Função observada no sistema | Limite da interpretação |
|---|---|---|
| USER | Clientes e comerciantes cadastrados pelo inicializador; criação de contas próprias no fluxo de preparação | Não significa permissão universal em qualquer objeto |
| BANK | Identidade utilizada em comunicação bancária; retirada exige BANK | Não é papel administrativo geral |
| CC | Processador de cartões; processamento de cartão no banco exige CC | Não equivale a cliente USER |

No login, a identidade contém username e role. As precondições exigem identidades e papéis previamente conferidos; o teste não tenta falsificar ou comprometer tokens.

## Persistência

| Modelo/tabela | Campos relevantes | Uso na observação |
|---|---|---|
| UserModel / user | id, username, role | Identificar executor e papel |
| AccountModel / account | id, account_number, balance, owner_id | Confirmar propriedade, saldo e criação |
| TransactionModel / transaction | id, amount, type, account_id, counterpart_name, counterpart_acct, fraud_flag | Verificar persistência de depósito e nome registrado |

owner_id vincula conta ao usuário. account_id da transação vincula a conta movimentada; não é o identificador do executor. O modelo de transação examinado não possui campo específico actor_id ou equivalente que vincule diretamente o executor autenticado.

Os métodos save_to_db confirmam suas operações individualmente. No depósito, a transação é confirmada antes da aplicação e gravação do saldo. A resposta de erro, isoladamente, não comprova ausência de efeitos.

## Estado e evidências de execução a coletar futuramente

- Identificação da execução, cenário, condição, instante e versão do ambiente.
- Solicitação e resposta, com tratamento adequado das credenciais no material compartilhado.
- Estado inicial e final das contas e registros financeiros no banco isolado.
- Resultado esperado definido pelas políticas, resultado observado e explicação de divergências.
- Separação entre violação da política, erro do ambiente/implementação e resultado inconclusivo.

Não depender apenas do histórico apresentado por A para observar a conta de B: a consulta de histórico também verifica propriedade. A inspeção autorizada do banco isolado ou a consulta por B poderá fornecer evidência; o método de coleta será fixado no protocolo.
