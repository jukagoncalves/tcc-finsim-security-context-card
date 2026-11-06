# Evidências de código

Trechos copiados da cópia local em 15/10/2026. Numeração à esquerda indica a linha original; não faz parte do código. As interpretações são inspeções estáticas, não resultados experimentais. Caminhos relativos à raiz registrada em 00_controle.md.

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
