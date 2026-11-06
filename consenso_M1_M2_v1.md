# Consolidação do consenso de M1 e M2 — v1

Data de organização documental: 24/10/2026. Fonte: fichas e confirmações fornecidas na conversa pelos pesquisadores. O usuário informou que Maria Júlia concorda com as revisões das fichas e confirmou o erro de digitação em C0-S1. Não se atribui a data desta consolidação ao julgamento original. Não se inferem julgamentos individuais independentes nem se calcula concordância interavaliadores a partir deste consenso.

Elaborado com assistência de IA. As justificativas abaixo explicitam a aplicação da rubrica aos textos consolidados; não são transcrições literais das justificativas individuais. Preservam-se a ficha_avaliacao_gqm_v1.md e as mensagens originais. Textos integrais: rastreabilidade_requisitos_execucoes_v1.md, seção Origem dos textos.

## 1. Resultado consolidado

M1: identidade, objeto, operação, resultado esperado e efeito no estado, cada um com 0/1. M2: claro quando CL1, CL2 e CL3 são atendidos.

| Requisito | Identidade | Objeto | Operação | Resultado | Estado | M1 | CL1 | CL2 | CL3 | Claro |
|---|---:|---:|---:|---:|---:|---:|---|---|---|---|
| C0-S1-R01 | 1 | 1 | 1 | 1 | 1 | 5 | Sim | Sim | Sim | Sim |
| C1-S1-R01 | 1 | 1 | 1 | 1 | 1 | 5 | Sim | Sim | Sim | Sim |
| C0-S2-R01 | 1 | 1 | 1 | 1 | 1 | 5 | Sim | Sim | Sim | Sim |
| C1-S2-R01 | 1 | 1 | 1 | 1 | 1 | 5 | Sim | Sim | Sim | Sim |
| C0-S3-R01 | 1 | 1 | 1 | 1 | 1 | 5 | Sim | Sim | Sim | Sim |
| C1-S3-R01 | 1 | 1 | 1 | 1 | 1 | 5 | Sim | Sim | Sim | Sim |

## 2. Fundamentação e limites do consenso

### S1
Em C0, identidade: “executor A com token valido e papel USER”; objeto: “conta pertencente a B”; operação: “consultar os dados”; resultado: impedir A de obter os dados; estado: “inalterados”. Em C1, os mesmos cinco elementos aparecem na identidade A/USER/token válido, conta existente de B distinto de A, consulta, impedimento de obtenção dos dados e preservação do estado e dos registros financeiros.

CL1: executor, objeto e consulta estão identificados no contexto S1. CL2: não divulgação e preservação do estado podem ser observadas. CL3: o texto não contradiz a política adotada. Mantém-se o consenso de clareza informado, sem interpretar essa marcação como prova de cobertura integral: “dados” e “demais registros” são expressões amplas, e a execução verificou apenas /web/account e histórico vazio. Clareza do requisito e cobertura do teste são avaliações distintas.

### S2
Os textos de C0 e C1 são idênticos nas fichas enviadas. Identidade: A, USER e token válido; objeto: conta existente de B; operação: depósito positivo com counterpart_name de B; resultado: rejeitar por divergência da identidade autenticada; efeito: não alterar saldo nem persistir transação de depósito.

CL1: atores, objeto e operação identificados. CL2: rejeição, saldo e persistência verificáveis. CL3: coerente com a política de que counterpart_name represente o iniciador autenticado, sem proibir destino em conta de terceiro. A concretização do valor e dos dados válidos pertence à preparação do teste.

### S3
Os textos de C0 e C1 são idênticos nas fichas enviadas. Identidade: CC e token válido; objeto: conta cuja criação é solicitada, com número válido e não utilizado; operação: criação por POST /account/create; resultado: negar por falta de autorização; efeito: “sem persistir uma nova conta nem alterar contas existentes”. Um objeto a criar não precisa existir previamente para estar identificado no requisito.

CL1: papel, recurso e operação explícitos. CL2: ausência de nova conta e preservação das existentes observáveis. CL3: coerente com a política restrita a USER. A falta de aplicação dessa política no código não torna o requisito inconsistente.

## 3. Revisões preservadas

- S3: nas fichas inicialmente enviadas, objeto e efeito no estado foram marcados como 0, resultando em M1=3. A revisão reconheceu os dois elementos expressos no texto, elevando M1 para 5. O registro individual antigo não foi sobrescrito; esta tabela registra o consenso posterior informado.
- C0-S1 na ficha atribuída a Maria Júlia: o usuário confirmou erro de digitação/cópia. O consenso consolidado refere-se ao requisito de consulta, não ao texto de depósito colado por engano. Não há reconstrução fictícia de uma ficha individual corrigida.
- Justificativas inicialmente resumidas como “sim” foram explicitadas neste documento como fundamentação da consolidação, sem atribuí-las retroativamente aos avaliadores.

## 4. Resumo por condição

| Condição | N | Distribuição M1 | Soma M1 | Média M1 | Requisitos 5/5 | M2 claros | M2/N |
|---|---:|---|---:|---:|---:|---:|---:|
| C0 | 3 | 5, 5, 5 | 15 | 5,00 | 3 | 3 | 100% |
| C1 | 3 | 5, 5, 5 | 15 | 5,00 | 3 | 3 | 100% |

A igualdade descreve os textos finais e o consenso informado. Não comprova independência das derivações, equivalência estatística entre métodos ou efeito causal do Card. A rubrica binária de presença não distingue graus de detalhamento quando ambos os textos já recebem 5/5.