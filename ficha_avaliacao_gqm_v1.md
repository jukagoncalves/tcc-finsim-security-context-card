# Ficha de avaliação GQM — versão 1

Preparada em 16/10/2026 com assistência de Codex. Propostas de operacionalização aceitas na conversa. As tabelas são modelos vazios, sem avaliações ou resultados experimentais. Preencher pelos pesquisadores e preservar as versões originais.

## 1. Finalidade e limites

Operacionalizar M1–M5 da Tabela 3.1 da monografia. Utilizar as políticas P1–P3, os cenários S1–S3 e as apresentações C0/C1 já revisadas. Política é a referência do comportamento esperado; o código não substitui o oráculo.

- C0: documentação convencional. C1: mesmas informações organizadas em Cards.
- Derivação e avaliação realizadas pelos pesquisadores. A preparação desta ficha não é uma derivação.
- Os requisitos já discutidos com IA não devem ser copiados como se fossem novas derivações independentes.
- Ordem, participação e quantidade de requisitos estão registradas em procedimento_derivacao_v1.md. Não há limite ou medição de tempo. Repetições de execução ainda serão definidas antes da coleta de M3/M4.
- Cada pesquisador avaliará individualmente M1/M2 de todos os requisitos de C0 e C1, após concluir as duas listas, sem consultar as marcações do outro; depois registrarão o consenso. M1/M2 são avaliadas sobre os textos derivados. M3 requer evidência de execução; M4 depende das execuções; M5 depende dos resultados das duas condições.

## 2. Identificação e rastreabilidade

| Campo | Preenchimento |
|---|---|
| Versão do pacote comum e apresentações | A preencher |
| Identificação/hash dos arquivos de entrada | A preencher |
| Sessão e data | A preencher |
| Condição e posição na ordem de aplicação | A preencher |
| Responsável pela derivação e participantes | A preencher |
| Avaliadores | A preencher |
| Materiais permitidos | A preencher |
| Conhecimento/acesso a resultados da outra condição | A preencher |
| Local da lista original derivada | A preencher |
| Versão do código e ambiente, quando executado | A preencher |

Identificar cada requisito pela condição, cenário e sequência, por exemplo C0-S1-R01. O exemplo é somente uma convenção de identificação. Não pressupõe quantidade de requisitos. Cada execução recebe identificador próprio vinculado ao requisito e à sua versão. Correções posteriores não substituem o original; registrar conteúdo alterado, data e motivo.

## 3. M1 — Presença dos elementos necessários (Q1)

Para cada requisito, atribuir 1 a cada elemento presente e 0 a cada elemento ausente. Presença exige texto explícito ou referência inequívoca a uma informação identificada no material; não completar por conhecimento do avaliador. Registrar a passagem ou referência que sustenta a marcação.

| Elemento | Critério |
|---|---|
| Identidade | Identifica executor e papel quando pertinente ao cenário |
| Objeto | Identifica o recurso consultado, movimentado ou criado |
| Operação | Define a ação solicitada |
| Resultado esperado | Define o comportamento esperado da resposta/decisão |
| Efeito no estado | Define alterações ou invariantes esperados nos registros financeiros |

M1 por requisito = soma dos cinco indicadores, de 0 a 5. Registrar quais faltam, não apenas o total. Precondições são registradas separadamente e não acrescentam um sexto elemento. Presença não comprova correção: eventual contradição com política deve ser registrada também em M2.

Para comparação descritiva, apresentar por cenário e condição: quantidade de requisitos N; distribuição dos escores; número com 5/5; média = soma dos escores/N. A média é uma forma de resumir M1, não uma nova métrica nem um limiar de qualidade. Se N=0, média não calculável.

## 4. M2 — Requisitos claros (Q2)

Julgar individualmente três critérios:

| Código | Critério para resposta “sim” |
|---|---|
| CL1 | Executor, objeto e ação têm interpretação inequívoca |
| CL2 | Resultado e efeito esperado são observáveis, sem expressões vagas |
| CL3 | O texto é internamente consistente e não contradiz cenário ou política |

Classificar como claro apenas quando os três critérios forem atendidos. Cada “não” recebe justificativa textual. Ausência em M1 pode também prejudicar clareza, mas não torna automaticamente todos os critérios de M2 negativos.

M2 = número de requisitos classificados como claros. Proporção = M2/N; apresentar também numerador e denominador. Se N=0, não calcular. Preservar avaliação de cada pesquisador e, em registro separado, decisão discutida e justificativa. Não alegar concordância independente se houve discussão prévia.

### Registro individual de M1 e M2 — repetir por requisito e avaliador

| Campo | Preenchimento |
|---|---|
| ID e versão do requisito / condição / cenário | C0-S3-R01  / C0 / S3 |
| Avaliador e data | Juka, 21/10/2026 |
| Texto original ou referência ao arquivo e localização | Quando uma identidade autenticada com papel CC e token válido solicitar a criação de uma conta por POST /account/create, informando um número válido e ainda não utilizado, o sistema deverá negar a criação por falta de autorização, conforme a política que permite essa operação somente ao papel USER, sem persistir uma nova conta nem alterar contas existentes. |
| Identidade: 0/1 e evidência | 1 . "Quando uma identidade autenticada com papel CC e token válido" |
| Objeto: 0/1 e evidência | 0 |
| Operação: 0/1 e evidência | 1. "solicitar a criação de uma conta por POST /account/create" |
| Resultado esperado: 0/1 e evidência | 1. "o sistema deverá negar a criação por falta de autorização" |
| Efeito no estado: 0/1 e evidência | 0" |
| Total M1: 0–5 | 3 |
| CL1: sim/não e justificativa | Sim|
| CL2: sim/não e justificativa | Sim, verificar a existencia de conta nova |
| CL3: sim/não e justificativa | sim, conforme a política que permite essa operação somente ao papel USER |
| Claro: sim/não | sim |
| Precondições e ambiguidades adicionais | nenhuma foi identificado |

### Discussão das avaliações — preservar os registros individuais

| Requisito | Divergência entre avaliações | Decisão final M1/M2 | Fundamentação | Participantes/data |
|---|---|---|---|---|
| A preencher | A preencher | A preencher | A preencher | A preencher |

## 5. M3 — Executabilidade sem alteração conceitual (Q2)

Classificar cada requisito como:

- **Executável:** foi operacionalizado e executado, permitindo observar o comportamento investigado sem alterar seu significado. Pode revelar uma violação da política e ainda ser executável.
- **Não executável sem alteração conceitual:** demonstrou-se que sua execução exige mudar executor/papel, objeto essencial, operação, regra ou resultado esperado. Justificar com evidência; não usar como categoria genérica para qualquer falha.
- **Pendente:** não executado, evidência insuficiente ou bloqueio técnico não resolvido.

Escolher usernames, número novo ou valor positivo pode ser detalhamento operacional, desde que respeite o requisito. Trocar CC por USER em S3 é mudança conceitual. Inserir uma proteção nova no sistema altera o objeto estudado; não é simples preparação do teste.

M3 = número de requisitos executáveis. Proporção = M3/N. Apresentar conjuntamente quantos são não executáveis e pendentes. Se houver pendências, declarar que M3 ainda é parcial; não interpretar pendência como impossibilidade comprovada. Várias execuções do mesmo requisito não multiplicam M3.

| Requisito/versão | Situação M3 | Detalhamento operacional realizado | Execuções/evidências | Alteração conceitual necessária ou bloqueio | Justificativa/data |
|---|---|---|---|---|---|
| A preencher | A preencher | A preencher | A preencher | A preencher | A preencher |

## 6. M4 — Correspondência entre execução e oráculo (Q3)

Definir o oráculo antes da execução a partir de política, cenário e requisito. Conferir tanto a resposta quanto os efeitos persistentes. Não mudar o oráculo para coincidir com o observado.

| Cenário | Pontos mínimos de observação segundo a política |
|---|---|
| S1 | Não exposição dos dados protegidos de B e estado financeiro inalterado |
| S2 | Rejeição da identidade divergente, saldo inalterado e ausência de transação financeira de depósito |
| S3 | Negação por papel, ausência de nova conta e contas existentes inalteradas |

Classificar a execução:

- **Correspondente:** evidências suficientes mostram correspondência da resposta/decisão e do estado com o oráculo.
- **Divergente:** há evidência de violação de pelo menos uma expectativa do oráculo. Se houver depósito persistido e erro técnico na resposta, registrar a divergência do estado e o erro técnico; não esconder o efeito conhecido como inconclusivo.
- **Inconclusiva:** a evidência não permite avaliar a regra, por exemplo uma falha técnica anterior ao processamento, sem violação observável já estabelecida. Ausência de efeito em uma operação que falhou tecnicamente não prova autorização correta.

Totais: T = tentativas incluídas na coleta; C = correspondentes; D = divergentes; I = inconclusivas; T=C+D+I. E=C+D representa execuções avaliáveis. M4=C. Apresentar contagens e os dois denominadores explicitamente:

- C/T: correspondência sobre todas as tentativas, mantendo visível o denominador “número de execuções” da Tabela 3.2.
- C/E: correspondência entre execuções avaliáveis, conforme proposta de separar inconclusivas; nunca apresentar essa proporção sozinha ou omitir I.

Se o denominador for zero, registrar “não calculável”, nunca 0%. Ensaios de preparação e coletas finais devem ser identificados separadamente; critérios de inclusão e repetições devem ser fixados antes de observar os resultados. Uma execução divergente pode provir de um requisito válido e bem executado; M4 não é medida direta de qualidade do requisito.

| Campo por execução | Preenchimento |
|---|---|
| ID da execução / requisito e versão / condição / cenário | A preencher |
| Ambiente, código, data e executor | A preencher |
| Oráculo e política de referência antes da execução | A preencher |
| Precondições verificadas e estado inicial | A preencher |
| Solicitação e resposta: arquivos de evidência | A preencher |
| Estado final e comparação: arquivos de evidência | A preencher |
| Resultado e efeitos observados | A preencher |
| Classificação: correspondente/divergente/inconclusiva | A preencher |
| Justificativa e erro técnico, se houver | A preencher |

A mensagem de rejeição não basta se houver efeito financeiro indevido. Registro de auditoria não equivale a transação financeira. No depósito, verificar explicitamente persistência parcial.

## 7. M5 — Diferença entre C0 e C1 (Q4)

Comparação principal: M1, M2 e M3, conforme a linha de Q4 na Tabela 3.2. Para cada medida comparável: Δ = valor de C1 − valor de C0. M4 responde Q3 e aparece como informação complementar por condição, não como prova direta de contribuição do Card.

| Medida de comparação | Valor C0 | Valor C1 | Δ C1−C0 |
|---|---|---|---|
| Média de M1 (escala 0–5) | A preencher | A preencher | A preencher |
| Proporção de requisitos claros M2/N | A preencher | A preencher | A preencher |
| Proporção executável M3/N, com pendências declaradas | A preencher | A preencher | A preencher |

Repetir por cenário e apresentar o conjunto com N por condição. Manter os valores absolutos M2/M3 e as distribuições de M1. Em proporções expressas em %, apresentar Δ em pontos percentuais. Não confundir com variação percentual relativa. Se as quantidades de requisitos diferirem, discutir a diferença e a granularidade; contagens maiores não indicam automaticamente melhoria.

Não somar as três diferenças em um escore único. Se as dimensões tiverem sinais diferentes, relatar contribuição por dimensão e o conflito, sem declarar melhoria global automática. Δ=0 e Δ<0 devem ser preservados. Se um valor não for calculável, a diferença correspondente também não é calculável. Comparar cenários equivalentes; não inventar pareamento individual quando as listas tiverem requisitos diferentes.

A monografia também menciona correspondência com resultados esperados no texto explicativo de Q4. A interpretação adotada nesta ficha torna M1–M3 principais e M4 complementar; harmonizar a redação metodológica antes de apresentar as conclusões, preservando os dados.

### Resumo de contagens por condição e cenário

| Condição/cenário | N requisitos | M1: distribuição e média | M2 claros | M3 executáveis | Não executáveis | Pendentes M3 | T tentativas | C=M4 | D | I |
|---|---|---|---|---|---|---|---|---|---|---|
| A preencher | A preencher | A preencher | A preencher | A preencher | A preencher | A preencher | A preencher | A preencher | A preencher | A preencher |

## 8. Próxima decisão antes da derivação

Aplicar procedimento_derivacao_v1.md: C0 antes de C1, Juka organiza e Maria Júlia verifica, três requisitos principais por condição e avaliação individual de ambas as listas pelos dois pesquisadores. Não medir tempo. Preservar primeiras versões e registrar desvios. Os pesquisadores já conhecem os requisitos e ambas as apresentações; nenhuma escolha de ordem elimina esse histórico. Registrar aprendizado e memória como limitações. Só então produzir as listas originais de cada condição.

## 9. Controle de alterações

| Versão | Data | Registro |
|---|---|---|
| v1 | 16/10/2026 | Consolidação das propostas M1–M5 aceitas; explicitados os denominadores de M4 e o tratamento de dados pendentes/inconclusivos |

Mudanças nas rubricas após a coleta devem ser justificadas e identificadas; manter os julgamentos originais. Não alterar critérios seletivamente para favorecer uma condição.
