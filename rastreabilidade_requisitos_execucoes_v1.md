# Rastreabilidade dos requisitos e execuções — v1

Preparado em 24/10/2026 com assistência de IA, por leitura dos arquivos de evidência. Associação retrospectiva às condições C0/C1; não representa execuções independentes por condição. Não foram realizados novos testes nesta conferência.

## Origem dos textos
Os textos abaixo foram transcritos das fichas enviadas pelos pesquisadores na conversa. O registro_derivacao_C0.md local ainda contém campos vazios e não foi localizada lista final C1 nos arquivos pesquisados. Esta consolidação não substitui primeiras versões de derivação nem comprova sua independência. A identificação v1 deste documento não atribui retroativamente versão aos requisitos originais.

### C0-S1-R01
Quando o executor A com token valido e papel USER tentar consultar os dados da conta pertencente a B  , o sistema devera negar a autorizaçao sobre essa funcionalidade impedindo A de obter os dados de B, mantendo os dados e demais registros da conta de B ocultos, inalterados e protegidos.

### C1-S1-R01
Quando o usuário A, autenticado com papel `USER` e token válido, consultar os dados de uma conta existente pertencente ao usuário B, distinto de A, o sistema deverá impedir que A obtenha os dados protegidos dessa conta, mantendo seu estado e seus registros financeiros inalterados.

### C0-S2-R01 e C1-S2-R01 — texto idêntico nas fichas enviadas
Quando o usuário A, autenticado com papel USER e token válido, solicitar um depósito de valor positivo na conta existente pertencente ao usuário B, distinto de A, com os demais dados válidos, mas informando o nome de usuário de B em counterpart_name, o sistema deverá rejeitar a solicitação por divergência em relação à identidade autenticada, sem alterar o saldo de B nem persistir uma transação financeira de depósito.

### C0-S3-R01 e C1-S3-R01 — texto idêntico nas fichas enviadas
Quando uma identidade autenticada com papel CC e token válido solicitar a criação de uma conta por POST /account/create, informando um número válido e ainda não utilizado, o sistema deverá negar a criação por falta de autorização, conforme a política que permite essa operação somente ao papel USER, sem persistir uma nova conta nem alterar contas existentes.

## Catálogo de evidências
Caminhos relativos à pasta TCC. Identificadores E1–E4 atribuídos nesta consolidação.

- E0: ambiente_finsim_v1/evidencias/S1_resposta_A.json. Primeira tentativa S1: resposta com campos nulos; estado financeiro anterior incompletamente registrado. Preservar como tentativa com limitação, sem afirmar que sua exclusão da coleta foi definida antecipadamente.
- E1: ambiente_finsim_v1/evidencias/S1_execucao02/. Arquivos: conta_antes.json, conta_depois.json, transacoes_antes.json, transacoes_depois.json, resposta_A_20261024_161732_722.json. Solicitação GET /web/account por A; HTTP 200 e campos nulos. Conta 1, número 2000000000000002, saldo 0.00 em ambos os estados; transações [] em ambos. Método, URI, executor e horário constam do registro da resposta.
- E2: ambiente_finsim_v1/evidencias/S2_20261024_163025_182/. Arquivos: requisicao_A.json, resposta_A.json, conta_antes.json, conta_depois.json, transacoes_antes.json, transacoes_depois.json, bnk_000_log_apos_S2.txt, log_api_apos_deposito.txt. HTTP 500; saldo 0.00 e transações [] antes/depois. Exceção da busca do usuário documentada anteriormente na conversa e preservada no log.
- E3: ambiente_finsim_v1/evidencias/S3_20261024_165329_705/. Arquivos: requisicao_CC.json, resposta_CC.json, contas_antes.json, contas_depois.json. HTTP 200, mensagem de criação; nova conta 3000000000000003, ID 2, proprietário 3 e saldo 0.00. Conta de B inalterada nos campos consultados.
- E4: ambiente_finsim_v2/evidencias/S2_v2_20261024_171807_517/. Arquivos: requisicao_A.json, resposta_A.json, conta_antes.json, conta_depois.json, transacoes_antes.json, transacoes_depois.json. HTTP 200; saldo de 0.00 para 10.00; crédito ID 1, amount 10.00, counterpart_name tcc_usuario_b, apesar de executor A.
- Controle da v2: ambiente_finsim_v2/CORRECAO_TECNICA_S2.md e manifesto_correcao.json. Correção da extração de username em BankDeposit, sem inclusão da regra de identidade.

## Matriz de associação

| Requisito | Evidência compartilhada | Ambiente | M3 no escopo executado | M4 da execução associada | Cobertura e limites |
|---|---|---|---|---|---|
| C0-S1-R01 | E1; E0 complementar | v1 | Executável no recorte observado | Correspondente no recorte observado | Consulta /web/account; saldo zero; histórico vazio. Não comprova ocultação de históricos preexistentes ou proteção de outros endpoints. |
| C1-S1-R01 | E1; E0 complementar | v1 | Executável no recorte observado | Correspondente no recorte observado | Mesmo recorte; A e B distintos e conta existente na preparação relatada. |
| C0-S2-R01 | E2 e E4, separados | v1 e v2 | v1: pendente por bloqueio; v2: executável após correção técnica | v1: inconclusivo; v2: divergente | Em v2 há violação persistente do oráculo. Não demonstra aplicação da regra na v1. |
| C1-S2-R01 | E2 e E4, separados | v1 e v2 | v1: pendente por bloqueio; v2: executável após correção técnica | v1: inconclusivo; v2: divergente | Mesmo texto de C0; mesma evidência associada retrospectivamente, sem nova execução. |
| C0-S3-R01 | E3 | v1 | Executável | Divergente | Criação indevida basta para estabelecer divergência; conta anterior preservada nos campos id, número, saldo e owner_id. |
| C1-S3-R01 | E3 | v1 | Executável | Divergente | Mesmo texto de C0 e mesma evidência. Não houve execução adicional independente. |

## Limitações e próximos registros

1. Correspondência de S1 é restrita ao caso operacionalizado; não afirmar cobertura integral da expressão ampla “demais registros ocultos e protegidos”. O estado observado inclui apenas os campos consultados e histórico vazio.
2. Identidades e papéis constam dos procedimentos e relatos de preparação; os arquivos não incluem tokens, intencionalmente. Não confundir metadados declarados da requisição com uma captura independente do estado de usuários no banco.
3. A associação C0/C1 foi feita depois dos testes. Um arquivo ligado a dois requisitos continua sendo uma única execução física. Não duplicar o total global de tentativas.
4. Preservar E0–E4 e registrar que a repetição de S1 foi decidida após a identificação de uma lacuna. Não apresentar critério retrospectivo de inclusão como previamente fixado.
5. Apresentar resultados por versão. A comparação no ambiente comum v1 mantém o bloqueio de S2 visível; E4 é evidência complementar na versão corrigida. Não substituir silenciosamente E2 por E4 ao calcular métricas.
6. As evidências sustentam avaliações dos requisitos finais, mas não provam benefício causal do Security Context-Card. Derivação assistida, conhecimento prévio e harmonização dos textos limitam a comparação.
7. O arquivo local ficha_avaliacao_gqm_v1.md ainda contém uma marcação individual antiga de C0-S3 (M1=3), enquanto a conversa registra revisão posterior. Preservar o original e registrar o consenso separadamente antes de calcular M5.
8. Próximo passo: revisar esta associação e consolidar M3/M4 em registro separado, sem substituir textos originais ou julgamentos individuais. M5 ainda não calculada.

## Atualização de inclusão na análise — 24/10/2026

Por solicitação do pesquisador, E0 foi retirada das contagens consolidadas. Ela permanece apenas como histórico e não apoia a pontuação atual dos requisitos S1; E1 é a execução incluída de S1. Esta decisão é retrospectiva. Os resultados e os arquivos originais não foram alterados. Para as contagens vigentes, consultar consolidacao_M3_M4_v2.md, que substitui a consolidação documental v1. As menções anteriores a E0 nesta matriz devem ser lidas como referências históricas.
