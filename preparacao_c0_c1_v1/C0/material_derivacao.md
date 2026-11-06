# C0 — Documentação convencional

Apresentação de entrada para derivação pelos pesquisadores. Os blocos abaixo preservam literalmente os conteúdos da fonte; apenas títulos e ordem de apresentação variam entre C0 e C1. Os anexos compartilhados integram a apresentação e devem estar disponíveis durante a tarefa.

# Instruções e situação

<!-- bloco:TAREFA:inicio -->
# Instrução comum de derivação

Com base somente nas informações fornecidas nesta apresentação, derivem requisitos de teste para os três cenários S1, S2 e S3. Expressem quem executa a operação, sobre qual objeto, em quais condições, qual resultado deve ocorrer e qual efeito é esperado no estado do sistema. Registrem dúvidas e informações ausentes, sem completá-las por suposição. Não executem o sistema. Preservem a primeira versão da lista produzida, identificando autores, condição e data.

Este enunciado é idêntico nas duas condições e integra as apresentações revisadas. Não define quantidade de requisitos, tempo de tarefa ou ordem das condições. Os requisitos prontos da Etapa 2 não integram este material.

## Situação atual e proveniência

O pacote comum e as apresentações C0/C1 foram revisados e estão aprovados para a preparação da derivação. O procedimento comparativo ainda deve ser fechado. Assistência de IA: preparação das apresentações por Codex; derivação e avaliação cabem aos pesquisadores.

Os metadados de organização abaixo não são achados confirmados. Identificadores S1/S2/S3 correspondem aos cenários já definidos; não representam novas vulnerabilidades. Severidade, classificação formal da fraqueza e mitigação adicional permanecem não definidas. As políticas são as regras de referência adotadas no estudo.

<!-- bloco:TAREFA:fim -->

# Políticas de referência

<!-- bloco:P00:inicio -->
# Políticas de referência

Estas regras definem o comportamento esperado para o estudo. Sua adoção não demonstra que a implementação já as cumpra. A e B representam identidades diferentes. Nos cenários S1 e S2, ambos têm papel USER e B possui a conta de destino. Usar dados sintéticos.


<!-- bloco:P00:fim -->

<!-- bloco:P01:inicio -->
## P1 — Consulta restrita ao proprietário

Um usuário autenticado com papel USER somente pode consultar os dados protegidos de contas das quais é proprietário. A solicitação de A para a conta de B não deve revelar identificação interna, número ou saldo da conta de B, nem alterar seu estado financeiro.

- Origem: cenário da monografia, intenção descrita no comentário de GetAccountInfo e verificação de propriedade em AccountModel.account_exists (E1/E2).
- Situação: política adotada no estudo.
- Não fixa código HTTP ou mensagem literal de resposta. O formatador da API pode alterar o corpo retornado.


<!-- bloco:P01:fim -->

<!-- bloco:P02:inicio -->
## P2 — Identidade do iniciador do depósito direto

No depósito direto representado por POST /bank/deposit, counterpart_name deve conter exatamente o username do iniciador identificado pelo token válido. Se o token identifica A e counterpart_name declara B, a solicitação deve ser rejeitada, sem alterar saldos nem persistir uma transação financeira de depósito.

- A conta de destino pode pertencer a B. Sua propriedade não é o motivo da rejeição neste cenário.
- “Corresponder” será operacionalizado como igualdade exata com o username usado no cadastro/login; usar nomes sintéticos distintos e sem ambiguidades. Esta é a precisão operacional adotada no estudo.
- A regra é específica do depósito direto. Não se presume que counterpart_name represente o executor técnico em processamento de cartões ou retiradas entre bancos.
- Registro de auditoria da tentativa rejeitada, caso exista, não equivale a transação financeira de depósito.
- Origem: esclarecimento da orientação sobre impedir que A atue como B e análise do registro do depósito. O comentário do método descreve a contraparte como iniciadora (E3). A política do estudo define a correspondência com a identidade autenticada e a rejeição de divergências.
- Situação: política adotada no estudo.


<!-- bloco:P02:fim -->

<!-- bloco:P03:inicio -->
## P3 — Criação de conta por papel

Somente identidades autenticadas com papel USER podem criar contas pelo endpoint /account/create, vinculadas à própria identidade. Identidades CC e BANK não podem criar contas por esse endpoint. A tentativa rejeitada não deve persistir conta nova nem alterar contas existentes.

- Origem: política proposta e adotada pelos pesquisadores; o inicializador utiliza USER para criar contas de clientes/comerciantes, e RoleType define USER, BANK e CC (E5).
- O papel BANK não é tratado como administrador geral. Não adicionar papel ADMIN: ele não existe na enumeração examinada.
- O cenário negativo S3 usa CC; a proibição de BANK faz parte da política, mas não será exercitada por esse cenário.
- Situação: política adotada no estudo.


<!-- bloco:P03:fim -->

<!-- bloco:P04:inicio -->
## Limites

As três políticas não constituem uma especificação completa da segurança do FinSim. Cadastro de usuários, atribuição de papéis, assinatura de tokens e outras operações não são avaliados automaticamente por estes cenários. Políticas devem ser estabilizadas antes da coleta; mudanças posteriores exigem justificativa e avaliação de necessidade de nova coleta.

<!-- bloco:P04:fim -->

# Cenários de entrada

<!-- bloco:S00:inicio -->
# Cenários de entrada do estudo

Situação: cenários revisados e adotados no estudo. Estes são dados de entrada e expectativas, não resultados executados nem listas derivadas C0/C1.


<!-- bloco:S00:fim -->

<!-- bloco:S01:inicio -->
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


<!-- bloco:S01:fim -->

<!-- bloco:S02:inicio -->
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


<!-- bloco:S02:fim -->

<!-- bloco:S03:inicio -->
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


<!-- bloco:S03:fim -->

<!-- bloco:S04:inicio -->
## Dados concretos ainda a preparar

Usernames, credenciais, identificadores, números das contas, saldo inicial e valor positivo do depósito não foram fixados nem criados neste pacote. Devem ser definidos antes da execução, com dados sintéticos, ausência de operações concorrentes e estado inicial restaurável. A conta de B existe em S1/S2; a conta solicitada em S3 não existe.

<!-- bloco:S04:fim -->

# Interface e dados

<!-- bloco:API:inicio -->
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

<!-- bloco:API:fim -->

# Evidências de código

<!-- bloco:E00:inicio -->
# Evidências de código

Trechos copiados da cópia local em 15/10/2026. Numeração à esquerda indica a linha original; não faz parte do código. As interpretações são inspeções estáticas, não resultados experimentais. Caminhos relativos à raiz registrada em 00_controle.md.


<!-- bloco:E00:fim -->

<!-- bloco:E01:inicio -->
## E1 — Consulta da conta

O método exige token e condiciona o retorno dos dados à propriedade. O retorno final passa por marshal_with, portanto o texto da mensagem no código não garante o corpo recebido.


Fonte: `finsim-trans/src/finsim_trans/resources.py`, linhas 100–116. SHA-256: `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb`.

```text
100: ## ---
101: # @brief GetAccountInfo returns the account info for one bank account owned by the logged in user
102: #   Primarily used by finsim-web Angular frontend for bank
103: # @input number - account number that the user account wants to access
104: #   User must be logged into finsim-web/trans in order to be able to get their account information (authenticated via @jwt_required)
105: # @return account id, number, and balance for the requested account number IF the user does own the requested account
106: ## ---
107: class GetAccountInfo( Resource ):
108:     @jwt_required
109:     @marshal_with( account_fields )
110:     def get( self ):
111:         data = accountParser.parse_args()
112:         user = UserModel.find_by_username( get_jwt_identity()['username'] )
113:         if AccountModel.account_exists( user.id, data['number'] ) == True:
114:             account = AccountModel.find_by_account_number( data['number'] )
115:             return { 'id': account.id, 'account_number': account.account_number, 'balance': account.balance }
116:         return { 'message': 'Account does not exist or is not owned by current user.' }
```


<!-- bloco:E01:fim -->

<!-- bloco:E02:inicio -->
## E2 — Propriedade e conta

A conta possui owner_id; account_exists filtra simultaneamente owner_id e account_number.


Fonte: `finsim-trans/src/finsim_trans/models.py`, linhas 47–59. SHA-256: `75c109461ec4fee30f7975b896f15eeecb56deceea6f8d56ba4c0c0e39118c1b`.

```text
47: class AccountModel( db.Model ):
48:     __tablename__ = 'account'
49: 
50:     id = db.Column( db.Integer, primary_key = True )
51:     balance = db.Column( db.Numeric( precision = 19, scale = 2, asdecimal = True, decimal_return_scale = 2 ), nullable = False )
52:     account_number = db.Column( db.String( 16 ), unique = True, nullable = False )
53:     owner_id = db.Column( db.Integer, db.ForeignKey( 'user.id' ) )
54:     owner = db.relationship( "UserModel", back_populates="accounts" )
55:     transactions = db.relationship( "TransactionModel", back_populates="account" )
56: 
57:     def save_to_db( self ):
58:         db.session.add( self )
59:         db.session.commit()
```


Fonte: `finsim-trans/src/finsim_trans/models.py`, linhas 78–94. SHA-256: `75c109461ec4fee30f7975b896f15eeecb56deceea6f8d56ba4c0c0e39118c1b`.

```text
78:     @classmethod
79:     def find_by_account_number( cls, account_number ):
80:         return cls.query.filter_by( account_number = account_number ).first()
81: 
82:     @classmethod
83:     def find_by_id( cls, id ):
84:         return cls.query.filter_by( id = id ).first()
85: 
86:     @classmethod
87:     def find_all_by_id( cls, id ):
88:         return cls.query.filter_by( owner_id = id ).all()
89: 
90:     @classmethod
91:     def account_exists( cls, id, account_number ):
92:         if cls.query.filter_by( owner_id = id, account_number = account_number ).first() != None:
93:             return True
94:         return False
```


<!-- bloco:E02:fim -->

<!-- bloco:E03:inicio -->
## E3 — Entrada e processamento do depósito

O comentário descreve contraparte como iniciadora. O nome é copiado da entrada. Não há comparação explícita desse nome com a identidade autenticada no método; não se conclui execução bem-sucedida.


Fonte: `finsim-trans/src/finsim_trans/resources.py`, linhas 57–62. SHA-256: `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb`.

```text
57: #depositParser is used in BankDeposit resource
58: depositParser = reqparse.RequestParser()
59: depositParser.add_argument( 'amount', help = 'This field cannot be blank', required = True )
60: depositParser.add_argument( 'account', help = 'This field cannot be blank', required = True )
61: depositParser.add_argument( 'counterpart_name', help = 'This field cannot be blank', required = True )
62: depositParser.add_argument( 'counterpart_acct', help = 'This field cannot be blank', required = False )
```


Fonte: `finsim-trans/src/finsim_trans/resources.py`, linhas 273–294. SHA-256: `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb`.

```text
273: ## ---
274: # @brief BankDeposit deposits a specified amount into the bank account
275: # @input amount, account, counterpart_name, counterpart_acct - account is the account that will potentially have the amount added to its balance. Counterpart refers to who initiated the deposit
276: #   A user must be logged in in order to initiate a deposit
277: # @return id, balance, owner - counterpart indicates who initiated the deposit
278: ## ---
279: class BankDeposit( Resource ):
280:     @jwt_required
281:     def post( self ):
282:         data = depositParser.parse_args()
283:         user = UserModel.find_by_username( get_jwt_identity() )
284: 
285:         try:
286:             account = AccountModel.find_by_account_number( data['account'] )
287:             trans = TransactionModel( amount = data['amount'], type = TxType.CREDIT, account_id = account.id, counterpart_name = data['counterpart_name'], counterpart_acct = data['counterpart_acct'], fraud_flag = FraudType.NONE )
288:             trans.save_to_db()
289:             account.applyTransaction( trans )
290:             account.save_to_db()
291:             return jsonify( { 'id': account.id, 'balance': str(account.balance), 'owner': account.owner_id } )
292:         except Exception as e:
293:             print( e )
294:             return { 'message': 'There was a problem processing the credit transaction.' }
```


<!-- bloco:E03:fim -->

<!-- bloco:E04:inicio -->
## E4 — Transação, saldo e consulta do histórico

A contraparte é persistida e apresentada no histórico. save_to_db realiza commit. O saldo é atualizado por applyTransaction; no depósito, dados numéricos exigem atenção à compatibilidade de tipos.


Fonte: `finsim-trans/src/finsim_trans/models.py`, linhas 14–45. SHA-256: `75c109461ec4fee30f7975b896f15eeecb56deceea6f8d56ba4c0c0e39118c1b`.

```text
14: class FraudType( enum.Enum ):
15:     NONE = 0
16:     FLAG = 1
17: 
18: class RoleType( enum.Enum ):
19:     USER = 1
20:     BANK = 2
21:     CC = 3
22: 
23: class TransactionModel( db.Model ):
24:     __tablename__ = 'transaction'
25: 
26:     id = db.Column( db.Integer, primary_key = True )
27:     amount = db.Column( db.Numeric( precision = 19, scale = 2, asdecimal = True, decimal_return_scale = 2 ), nullable = False )
28:     type = db.Column( db.Enum( TxType ), nullable = False )
29:     account_id = db.Column( db.Integer, db.ForeignKey( 'account.id' ) )
30:     account = db.relationship( "AccountModel", back_populates="transactions" )
31:     counterpart_name = db.Column( db.String( 120))
32:     counterpart_acct = db.Column( db.String( 4 ))
33:     fraud_flag = db.Column( db.Enum( FraudType ), nullable = False )
34: 
35:     def save_to_db( self ):
36:         db.session.add( self )
37:         db.session.commit()
38: 
39:     @classmethod
40:     def find_all_by_account_id( cls, id ):
41:         return cls.query.filter_by( account_id = id ).all()
42: 
43:     @classmethod
44:     def find_by_id( cls, account_id, id ):
45:         return cls.query.filter_by( id = id, account_id = account_id ).first()
```


Fonte: `finsim-trans/src/finsim_trans/models.py`, linhas 61–76. SHA-256: `75c109461ec4fee30f7975b896f15eeecb56deceea6f8d56ba4c0c0e39118c1b`.

```text
61:     def applyTransaction( self, trans ):
62:         print( "Internal balance: " + str( self.balance ) )
63:         print( "amount type: {}".format( type( trans.amount ) ) )
64:         print( "balance type: {}".format( type( self.balance ) ) )
65:         if trans.type == TxType.CREDIT:
66:             self.balance = self.balance + trans.amount
67:         elif trans.type == TxType.DEBIT:
68:             self.balance = self.balance - trans.amount
69:             if self.balance < 0:
70:                 self.balance = self.balance + trans.amount
71:                 return False
72:         else:
73:             print( "Transaction not applied." )
74:             pass
75:         print( "Internal balance: " + str( self.balance ) )
76:         return True
```


Fonte: `finsim-trans/src/finsim_trans/resources.py`, linhas 35–38. SHA-256: `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb`.

```text
35: #account_fields used by ListAccounts and GetAccountInfo resources
36: account_fields = { 'id': fields.String, 'account_number': fields.String, 'balance': fields.String }
37: #transaction fields used by ListTransactions resource
38: transaction_fields = { 'id': fields.String, 'amount': fields.String, 'type': fields.String, 'account_id': fields.String, 'account': fields.String, 'counterpart_name': fields.String, 'counterpart_acct': fields.String }
```


Fonte: `finsim-trans/src/finsim_trans/resources.py`, linhas 118–138. SHA-256: `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb`.

```text
118: ## ---
119: # @brief ListTransactions returns a list of all the transactions that involves the input account
120: #   Primarily used by finsim-web Angular frontend for bank
121: # @input number - account number they want the transactions history of
122: #   User must be logged into finsim-web/trans in order to be able to get their account information (authenticated via @jwt_required)
123: # @return list of transactions
124: ## ---
125: class ListTransactions( Resource):
126:     @jwt_required
127:     @marshal_with( transaction_fields )
128:     def get( self ):
129:         data = accountParser.parse_args()
130:         user = UserModel.find_by_username( get_jwt_identity()['username'] )
131:         if AccountModel.account_exists( user.id, data['number'] ) == True:
132:             account = AccountModel.find_by_account_number( data['number'] )
133:             transactions = TransactionModel.find_all_by_account_id( account.id )
134: 
135:             for t in transactions:
136:                 print( t.id, t.amount, t.type, t.account_id )
137:             return transactions
138:         return { 'message': 'Account does not exist or is not owned by current user.' }
```


Fonte: `finsim-web/src/app/account-details/account-details.component.html`, linhas 1–25. SHA-256: `df565e38b3f9b050061d61c7153753dbb7d2f4a75dccd4b3a203eea3dddadfd6`.

```text
1: <!--
2:   FinSim
3:   Copyright 2018 Carnegie Mellon University. All Rights Reserved.
4:   NO WARRANTY. THIS CARNEGIE MELLON UNIVERSITY AND SOFTWARE ENGINEERING INSTITUTE MATERIAL IS FURNISHED ON AN "AS-IS" BASIS. CARNEGIE MELLON UNIVERSITY MAKES NO WARRANTIES OF ANY KIND, EITHER EXPRESSED OR IMPLIED, AS TO ANY MATTER INCLUDING, BUT NOT LIMITED TO, WARRANTY OF FITNESS FOR PURPOSE OR MERCHANTABILITY, EXCLUSIVITY, OR RESULTS OBTAINED FROM USE OF THE MATERIAL. CARNEGIE MELLON UNIVERSITY DOES NOT MAKE ANY WARRANTY OF ANY KIND WITH RESPECT TO FREEDOM FROM PATENT, TRADEMARK, OR COPYRIGHT INFRINGEMENT.
5:   Released under a MIT (SEI)-style license, please see license.txt or contact permission@sei.cmu.edu for full terms.
6: -->
7: <mat-card>
8:   <mat-card-content>
9:     Account Details
10:     <div *ngIf="bank_acct">
11:       <p> {{bank_acct.id}} | {{bank_acct.account_number}} | &#36;{{bank_acct.balance}} </p>
12:     </div>
13:   </mat-card-content>
14: </mat-card>
15: 
16: <mat-list>
17:     <div *ngIf="transactions?.length; else elseBlock">
18:       <p>Transaction ID | Amount | Type | Counterpart Name | Counterpart's Account Number</p>
19:       <mat-list-item *ngFor="let t of transactions">
20:         <p mat-line> {{t.id}} &#36;{{t.amount}} {{t.type}} {{t.counterpart_name}} {{t.counterpart_acct}}</p>
21:       </mat-list-item>
22:     </div>
23:     <ng-template #elseBlock>
24:       <p>No transactions listed for this account.</p>
25:     </ng-template>
```


<!-- bloco:E04:fim -->

<!-- bloco:E05:inicio -->
## E5 — Papéis, criação e uso no inicializador

Existem USER, BANK e CC. Criação vincula conta ao usuário identificado e não contém restrição por papel. O inicializador usa USER para criar contas de comerciantes e clientes; P3 é política do estudo, não regra já aplicada pelo método.


Fonte: `finsim-trans/src/finsim_trans/models.py`, linhas 18–21. SHA-256: `75c109461ec4fee30f7975b896f15eeecb56deceea6f8d56ba4c0c0e39118c1b`.

```text
18: class RoleType( enum.Enum ):
19:     USER = 1
20:     BANK = 2
21:     CC = 3
```


Fonte: `finsim-trans/src/finsim_trans/resources.py`, linhas 296–318. SHA-256: `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb`.

```text
296: ## ---
297: # @brief AccountCreation creates a bank account for the logged in user
298: # @input number - account number to create
299: #   A user must be logged in in order to create an account
300: # @return message - indicates result of account creation
301: ## ---
302: class AccountCreation( Resource ):
303:     @jwt_required
304:     def post( self ):
305:         # TODO maybe restrict this feature to certain roles (admin only)
306:         data = accountParser.parse_args()
307:         identity = get_jwt_identity()
308:         print( "{}".format( identity['role'] ) )
309:         user = UserModel.find_by_username( identity['username'] )
310:         print( "Creating account for {}".format( user.username ) )
311:         newAccount = AccountModel( balance = 0.0, owner_id = user.id, account_number = data['number'] )
312: 
313:         try:
314:             newAccount.save_to_db()
315:             return { 'message': 'Account created successfully' }
316:         except Exception as e:
317:             print( e )
318:             return { 'message': 'Could not create account' }
```


Fonte: `init_script.py`, linhas 200–237. SHA-256: `af3f513c48bd05b561a11e715f3936b711d9883a5a3efb0a53c9b187d3613ddd`.

```text
200:         current_component.append( user_list )
201:         if register_to_db:
202:             for cc in current_component[1]:
203:                 #Connect to bank and register the ccs
204:                 userReg = {"username": cc[3], "password": cc[4][int(component_id[1])][1], "role": "CC"}
205:                 regMessage = requests.post( current_component[0][1] + "registration", json = userReg, verify=False )
206:                 print( "Reg Message: " + regMessage.text )
207:             for merc in current_component[2]:
208:                 #Connect to bank and register the mercs. Register, login, create account for each merchant
209:                 userReg = {"username": merc[1], "password": merc[3][1], "role": "USER"}
210:                 regMessage = requests.post( current_component[0][1] + "registration", json = userReg, verify=False )
211:                 print( "Reg Message: " + regMessage.text )
212:                 loginForm = {"username": merc[1], "password": merc[3][1]}
213:                 token = requests.post( current_component[0][1] + "login", json = loginForm, verify=False ).json()
214:                 print( token['access_token'] )
215:                 header = { "Authorization": "Bearer " + token['access_token'], "Content-Type": "application/json" }
216:                 accountReg = { "number": "{}".format( merc[3][0] ) }
217:                 accountResponse = requests.post( current_component[0][1] + 'account/create', json = accountReg, headers = header, verify=False )
218:                 print( "Response Text: " + accountResponse.text )
219:             for user in current_component[3]:
220:                 #Connect to bank and register the users. Register, login, create account(s) for each user
221:                 userReg = {"username": user[1], "password": user[2], "role": "USER"}
222:                 regMessage = requests.post( current_component[0][1] + "registration", json = userReg, verify=False )
223:                 print( "Reg Message: " + regMessage.text )
224:                 loginForm = {"username": user[1], "password": user[2]}
225:                 token = requests.post( current_component[0][1] + "login", json = loginForm, verify=False ).json()
226:                 print( token['access_token'] )
227:                 header = { "Authorization": "Bearer " + token['access_token'], "Content-Type": "application/json" }
228:                 for account in user[3]:
229:                     accountReg = { "number": "{}".format( account ) }
230:                     accountResponse = requests.post( current_component[0][1] + 'account/create', json = accountReg, headers = header, verify=False )
231:                     print( "Response Text: " + accountResponse.text )
232:             for bank in current_component[0][4]:
233:                 #Connect to bank and register the other banks
234:                 if bank[0] != "CURRENT_BANK":
235:                     userReg = {"username": bank[4][0], "password": bank[4][1], "role": "BANK"}
236:                     regMessage = requests.post( current_component[0][1] + "registration", json = userReg, verify=False )
237:                     print( "Reg Message: " + regMessage.text )
```


<!-- bloco:E05:fim -->

<!-- bloco:E06:inicio -->
## E6 — Login e rotas

O login fornece identidade com username e role. Rotas correspondem às operações dos cenários.


Fonte: `finsim-trans/src/finsim_trans/resources.py`, linhas 344–363. SHA-256: `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb`.

```text
344: ## ---
345: # @brief  UserLogin is used by users to connect to finsim-trans
346: # @input  username, password
347: # @return  message, access_token, refresh_token - message indicates successful login
348: #           or failure message
349: ## ---
350: class UserLogin( Resource ):
351:     def post( self ):
352:         data = parserLogin.parse_args()
353:         current_user = UserModel.find_by_username( data['username'] )
354:         if not current_user:
355:             return {'message':'User {} does not exist.'.format(data['username']) }, 401
356: 
357:         if UserModel.verify_hash( data['password'], current_user.password ):
358:             identity = { 'username': data['username'], 'role':  current_user.role.name }
359:             access_token = create_access_token( identity = identity )
360:             refresh_token = create_refresh_token( identity = identity )
361:             return {'message': 'Logged in as {}.'.format( current_user.username ), 'access_token': access_token, 'refresh_token': refresh_token}
362:         else:
363:             return {'message': 'Wrong credentials'}, 401
```


Fonte: `finsim-trans/src/finsim_trans/__init__.py`, linhas 43–58. SHA-256: `0d761948672021fd8ce6870b82fb6a50b4f3f788ce95c1c871f7f60878895a6b`.

```text
43: #Routes in which to access each endpoint for finsim-trans
44: api.add_resource( resources.UserRegistration, '/registration' )
45: api.add_resource( resources.UserLogin, '/login' )
46: api.add_resource( resources.TokenRefresh, '/token/refresh' )
47: 
48: api.add_resource( resources.AccountCreation, '/account/create' )
49: api.add_resource( resources.BankDeposit, '/bank/deposit' )
50: api.add_resource( resources.BankWithdrawal, '/bank/withdrawal' )
51: 
52: api.add_resource( resources.ProcessCard, '/card/process' )
53: api.add_resource( resources.FlagAsFraud, '/flag/fraud' )
54: 
55: # Endpoints for the web frontend
56: api.add_resource( resources.ListAccounts, '/web/accounts' )
57: api.add_resource( resources.GetAccountInfo, '/web/account' )
58: api.add_resource( resources.ListTransactions, '/web/transactions' )
```

<!-- bloco:E06:fim -->

# Metadados de organização dos cenários

<!-- bloco:META1:inicio -->
| Campo | Conteúdo |
|---|---|
| finding_id | S1 — identificador do cenário, sem confirmação de vulnerabilidade |
| asset | Conta existente pertencente a B |
| weakness | Classificação formal não definida no pacote comum |
| severity | Não definida no pacote comum |
| mitigation | Mitigação adicional não definida no pacote comum |

<!-- bloco:META1:fim -->

<!-- bloco:META2:inicio -->
| Campo | Conteúdo |
|---|---|
| finding_id | S2 — identificador do cenário, sem confirmação de vulnerabilidade |
| asset | Conta existente pertencente a B |
| weakness | Classificação formal não definida no pacote comum |
| severity | Não definida no pacote comum |
| mitigation | Mitigação adicional não definida no pacote comum |

<!-- bloco:META2:fim -->

<!-- bloco:META3:inicio -->
| Campo | Conteúdo |
|---|---|
| finding_id | S3 — identificador do cenário, sem confirmação de vulnerabilidade |
| asset | Nova conta com número válido e ainda não utilizado |
| weakness | Classificação formal não definida no pacote comum |
| severity | Não definida no pacote comum |
| mitigation | Mitigação adicional não definida no pacote comum |

<!-- bloco:META3:fim -->

# Limitações e pendências

<!-- bloco:LIMITES:inicio -->
# Limitações e pendências

## O que foi feito

Inspeção estática de arquivos locais e consolidação documental das decisões da conversa. Nenhum banco foi criado, aplicativo iniciado, token emitido, requisição enviada ou experimento executado para preparar este pacote. Não se atribuem valores às métricas GQM.

## Possíveis obstáculos técnicos

1. Em BankDeposit, find_by_username recebe get_jwt_identity() inteiro, enquanto o login define identidade como dicionário com username e role. A busca pode falhar antes do try e antes de observar a política (E3/E6).
2. O parser do depósito não declara tipo numérico nem o método converte explicitamente amount antes de applyTransaction. Compatibilidade entre a entrada e o saldo decimal precisa ser verificada no ambiente (E3/E4).
3. O registro de transação recebe commit antes da atualização do saldo. Pode existir persistência parcial; não interpretar erro HTTP ou mensagem de falha como ausência de depósito registrado (E3/E4).
4. A formatação marshal_with pode transformar a resposta de negação de consulta. Não fixar a mensagem literal de GetAccountInfo como única evidência (E1).
5. O arquivo local finsim_trans/init_script.py contém apenas o texto ../../../init_script.py. Pode representar um link simbólico não preservado, impedindo importação pelo helper.py. Não foi reparado.
6. A configuração usa MySQL e tecnologias antigas do README. Dependências e instalação compatíveis ainda não foram verificadas. O pacote não exige executar toda a arquitetura ou finsim_1.0.

Erros técnicos devem ser separados da avaliação da regra. Ajustes de compatibilidade não podem introduzir silenciosamente a própria proteção que está sendo avaliada. Registrar antes/depois, justificativa e impacto de qualquer adaptação.

## Políticas e escopo

- P2 define igualdade exata de counterpart_name com username e rejeição sem efeitos financeiros quando houver divergência. É a política de referência do depósito direto neste estudo.
- P3 é política do estudo; o comentário TODO de AccountCreation não estabelece uma política original do FinSim.
- Campos de severidade, classe de fraqueza e mitigação adicional não foram arbitrados. Se exigidos pelo Card, usar “não definido” nas duas condições ou atualizar primeiro a fonte comum.
- O conteúdo não generaliza para outros sistemas, vulnerabilidades ou segurança global da aplicação.

## Antes de produzir derivações C0/C1

- [x] Pacote comum revisado e aprovado para preparação da derivação.
- [x] Políticas de referência definidas para os três cenários.
- [ ] Fixar o enunciado da tarefa e quais documentos serão apresentados nas duas condições.
- [ ] Mapear todos os fatos/evidências de C0 para C1, garantindo equivalência sem adicionar interpretações somente ao Card.
- [ ] Definir ordem, responsáveis e acesso às respostas anteriores; registrar a influência do conhecimento prévio dos requisitos.
- [ ] Definir o tratamento da Etapa 2: seus requisitos já completos não devem ser entregues como respostas prontas sem discussão do impacto na comparação.
- [ ] Fixar unidade de análise e quantidade de requisitos por cenário; rubricas de clareza/completude/executabilidade; tratamento de divergências; cálculo de M1–M5 e relação de M4 com Q4.
- [ ] Registrar as derivações originais e avaliações antes de consenso ou edição.

## Antes de executar

- [ ] Definir dados sintéticos concretos, ambiente, dependências, versão do código e mecanismo de restauração do estado.
- [ ] Verificar os possíveis bloqueios do depósito e documentar adaptações.
- [ ] Fixar critérios observáveis de rejeição; erro técnico não basta para comprovar autorização.
- [ ] Definir comparação dos registros e saldos antes/depois, sem operações concorrentes.
- [ ] Preservar solicitações, respostas e evidências; não preencher resultados antecipadamente.

## Ameaças à validade

Os mesmos pesquisadores definem políticas, conhecem requisitos previamente discutidos com IA, derivam e avaliam. Pode haver aprendizagem, memória, expectativa e julgamento compartilhado. Alternar funções não equivale a cegamento ou revisão independente. Registrar avaliações individuais antes do consenso ajuda a tornar decisões auditáveis, mas não elimina as ameaças. Três cenários sustentam conclusões locais e descritivas; resultados iguais ou piores em C1 também devem ser preservados.

## Uso de IA

A preparação deste pacote foi assistida por Codex. Os pesquisadores devem revisar e registrar esse uso e sua finalidade na declaração de IA exigida pela resolução institucional. Assistência documental e inspeção de código não substituem a derivação e a análise científica previstas para os pesquisadores.

<!-- bloco:LIMITES:fim -->

# Controle e proveniência originais

<!-- bloco:CONTROLE:inicio -->
# Pacote comum de informações — versão 1

## Identificação e situação

- Projeto: TCC sobre requisitos de teste de autorização e Security Context-Cards em uma versão reduzida do FinSim.
- Preparação documental: 15/10/2026, horário de referência America/Sao_Paulo.
- Pesquisadores: Juka Francis Pereira Gonçalves e Maria Júlia Pedroso Pimenta.
- Orientador: Prof. Dr. Bento Rafael Siqueira.
- Organização prevista: Juka conduz; Maria Júlia verifica, conforme a divisão da Etapa 3 na monografia.
- Preparação deste pacote: assistência de IA (Codex), a pedido dos pesquisadores, com inspeção estática do código local e uso das decisões registradas na conversa. A autoria/revisão científica cabe aos pesquisadores.
- Situação: pacote revisado e aprovado para preparação da derivação. O procedimento experimental ainda deve ser fechado; não há resultados de execução.
- Derivação C0/C1: será realizada pelos pesquisadores, conforme esclarecimento deles.

## Finalidade

Ser a fonte comum para preparar C0 (documentação sem Card) e C1 (mesmas informações organizadas em Security Context-Card). O pacote ainda não corresponde às duas apresentações finais. Preserva políticas, cenários, especificação de interface, evidências e limitações. Não inclui a lista de requisitos RT-S1 a RT-S3 como resposta pronta para a derivação.

## Conteúdo

| Documento | Conteúdo |
|---|---|
| 01_politicas.md | P1, P2 e P3 e sua fundamentação |
| 02_cenarios.md | Executor, objeto, operação, precondições, resultados e efeitos esperados |
| 03_api_e_dados.md | Operações, parâmetros, identidade, papéis e observação do estado |
| 04_evidencias_codigo.md | Trechos fiéis e numerados E1 a E6, fontes e hashes |
| 05_limitacoes.md | Incertezas técnicas, validade e decisões metodológicas pendentes |

## Fontes e identificação da cópia

- Repositório de referência informado pelos pesquisadores: https://github.com/cmu-sei/finsim
- Cópia inspecionada: `C:\Users\Steel Legend\Documents\Vida Academica\Iniciaçao Cientifica\finsim-master`.
- Componente focal: `finsim-trans`; `finsim_1.0` é material legado e não integra estas evidências.
- Commit da cópia local: NÃO DETERMINADO. A inspeção anterior da raiz não identificou diretório `.git`; o nome `finsim-master` não comprova branch nem versão. Não se presume equivalência ao commit citado no artigo.
- A identificação reproduzível abaixo usa SHA-256 dos arquivos efetivamente lidos. Não constitui snapshot integral do sistema e não congela dependências.
- Documentos acadêmicos de referência: monografia analisada (18 páginas, seção 3.1.5 e tabelas 3.1–3.3), artigo AISecDev em português (4 páginas) e Resolução BICT nº 3/2026 (13 páginas). Os originais não foram alterados.
- Decisões complementares: conversa de orientação com os pesquisadores e mensagens do orientador transcritas por Juka. Não houve contato direto da IA com o professor.

### Hashes da cópia inspecionada

| Arquivo relativo à raiz | SHA-256 |
|---|---|
| `finsim-trans/src/finsim_trans/resources.py` | `9bfd5adc5f4aa56d840a7a7e38bd253d5741654ee6904f5d5754a93d75c92bfb` |
| `finsim-trans/src/finsim_trans/models.py` | `75c109461ec4fee30f7975b896f15eeecb56deceea6f8d56ba4c0c0e39118c1b` |
| `finsim-trans/src/finsim_trans/__init__.py` | `0d761948672021fd8ce6870b82fb6a50b4f3f788ce95c1c871f7f60878895a6b` |
| `finsim-trans/src/finsim_trans/helper.py` | `abbfdee5226193c52aeb3e804d4b21f3c7e308c2625cce702dc04b7df7521568` |
| `finsim-trans/src/finsim_trans/init_script.py` | `f478dece377ded21f4918b5480f05633272c3470ce55a522b808b19aadbde126` |
| `init_script.py` | `af3f513c48bd05b561a11e715f3936b711d9883a5a3efb0a53c9b187d3613ddd` |
| `finsim-merch/merchant.py` | `7167637efe432f371d01fdc8e0275e5bad946202895675c1adae9e246bda07eb` |
| `finsim-web/src/app/account-details/account-details.component.html` | `df565e38b3f9b050061d61c7153753dbb7d2f4a75dccd4b3a203eea3dddadfd6` |
| `README.md` | `eb104f58f9b3a85ed8f6ab5a128ce33e9914b66e25b2a45e1812b37bc6cd0a89` |

## Regras de equivalência C0/C1

1. Ambas as condições recebem os mesmos fatos, políticas, precondições, evidências e limitações.
2. C0 deve ser legível e completo; não se deve desorganizá-lo intencionalmente.
3. C1 apenas reorganiza o conteúdo. Campos sem informação recebem “não definido”; não inventar severidade, fraqueza, mitigação ou resultados.
4. Se surgir informação nova, atualizar o pacote e as duas condições antes da derivação. Não corrigir apenas uma apresentação.
5. Preservar o mesmo enunciado de tarefa e registrar autoria, duração/recursos permitidos, ordem das condições e acesso a materiais anteriores.
6. Os pesquisadores já conheceram e revisaram requisitos com assistência de IA. Guardar esse histórico e registrar a ameaça de aprendizagem; não apresentar as derivações como independentes ou cegas.
7. Não modificar a implementação para satisfazer as políticas antes de medir seu comportamento. Ajustes de compatibilidade eventualmente necessários devem ser documentados e avaliados quanto a seus efeitos.

## Revisão e controle de mudanças

- [x] Juka conferiu o pacote comum.
- [x] Maria Júlia verificou o pacote comum.
- [ ] O desenho de derivação C0/C1 foi fechado antes de produzir dados comparativos.
- [ ] Foi registrada a versão do ambiente que será efetivamente executado.

| Versão | Data | Alteração | Situação |
|---|---|---|---|
| v1 | 15/10/2026 | Preparação inicial assistida por IA | Revisada |
| v1, revisão documental 1 | 15/10/2026 | Simplificação dos registros de contexto e aprovação, a pedido do usuário; políticas e evidências inalteradas | Atual |

Após alterações substantivas, preservar a versão anterior e registrar justificativa, responsável e nova versão.

<!-- bloco:CONTROLE:fim -->
