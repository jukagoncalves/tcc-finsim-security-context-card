# Políticas de referência

Estas regras definem o comportamento esperado para o estudo. Sua adoção não demonstra que a implementação já as cumpra. A e B representam identidades diferentes. Nos cenários S1 e S2, ambos têm papel USER e B possui a conta de destino. Usar dados sintéticos.

## P1 — Consulta restrita ao proprietário

Um usuário autenticado com papel USER somente pode consultar os dados protegidos de contas das quais é proprietário. A solicitação de A para a conta de B não deve revelar identificação interna, número ou saldo da conta de B, nem alterar seu estado financeiro.

- Origem: cenário da monografia, intenção descrita no comentário de GetAccountInfo e verificação de propriedade em AccountModel.account_exists (E1/E2).
- Situação: política adotada no estudo.
- Não fixa código HTTP ou mensagem literal de resposta. O formatador da API pode alterar o corpo retornado.

## P2 — Identidade do iniciador do depósito direto

No depósito direto representado por POST /bank/deposit, counterpart_name deve conter exatamente o username do iniciador identificado pelo token válido. Se o token identifica A e counterpart_name declara B, a solicitação deve ser rejeitada, sem alterar saldos nem persistir uma transação financeira de depósito.

- A conta de destino pode pertencer a B. Sua propriedade não é o motivo da rejeição neste cenário.
- “Corresponder” será operacionalizado como igualdade exata com o username usado no cadastro/login; usar nomes sintéticos distintos e sem ambiguidades. Esta é a precisão operacional adotada no estudo.
- A regra é específica do depósito direto. Não se presume que counterpart_name represente o executor técnico em processamento de cartões ou retiradas entre bancos.
- Registro de auditoria da tentativa rejeitada, caso exista, não equivale a transação financeira de depósito.
- Origem: esclarecimento da orientação sobre impedir que A atue como B e análise do registro do depósito. O comentário do método descreve a contraparte como iniciadora (E3). A política do estudo define a correspondência com a identidade autenticada e a rejeição de divergências.
- Situação: política adotada no estudo.

## P3 — Criação de conta por papel

Somente identidades autenticadas com papel USER podem criar contas pelo endpoint /account/create, vinculadas à própria identidade. Identidades CC e BANK não podem criar contas por esse endpoint. A tentativa rejeitada não deve persistir conta nova nem alterar contas existentes.

- Origem: política proposta e adotada pelos pesquisadores; o inicializador utiliza USER para criar contas de clientes/comerciantes, e RoleType define USER, BANK e CC (E5).
- O papel BANK não é tratado como administrador geral. Não adicionar papel ADMIN: ele não existe na enumeração examinada.
- O cenário negativo S3 usa CC; a proibição de BANK faz parte da política, mas não será exercitada por esse cenário.
- Situação: política adotada no estudo.

## Limites

As três políticas não constituem uma especificação completa da segurança do FinSim. Cadastro de usuários, atribuição de papéis, assinatura de tokens e outras operações não são avaliados automaticamente por estes cenários. Políticas devem ser estabilizadas antes da coleta; mudanças posteriores exigem justificativa e avaliação de necessidade de nova coleta.
