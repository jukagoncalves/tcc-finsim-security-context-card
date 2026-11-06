# Consolidação de M3 e M4 — registro v2

Data: 24/10/2026. Elaborado com assistência de IA a partir da matriz de rastreabilidade e das evidências salvas pelos pesquisadores. Esta é uma consolidação documental; não constitui nova execução, avaliação individual independente ou aceite dos pesquisadores.

## 1. Fontes e unidade de análise

Referências: ficha_avaliacao_gqm_v1.md e rastreabilidade_requisitos_execucoes_v1.md, na pasta TCC. A matriz contém os textos dos seis requisitos transcritos das fichas enviadas na conversa e os caminhos das evidências E0–E4. As listas finais locais de derivação continuam pendentes de consolidação.

M3 conta requisitos executáveis, não tentativas. M4 classifica execuções físicas: C (correspondente), D (divergente), I (inconclusiva). T=C+D+I e E=C+D. M4=C; apresentar C/T e C/E. Uma execução pode apoiar dois requisitos equivalentes sem se tornar duas execuções físicas.

As condições C0/C1 dizem respeito à apresentação para derivação. As versões v1/v2 dizem respeito à aplicação. São dimensões distintas. A associação das execuções às condições é retrospectiva e compartilhada.

## 2. M3 por requisito na versão comum v1

| Requisito | Situação | Evidências | Fundamentação e limites |
|---|---|---|---|
| C0-S1-R01 | Executável no caso operacionalizado | E1 | A consulta como A foi realizada e comparada com consultas de B antes/depois. Verificados /web/account, saldo zero e histórico vazio; não generalizar para outros endpoints ou registros preexistentes. |
| C1-S1-R01 | Executável no caso operacionalizado | E1, compartilhada com C0 | Mesmas precondições, operação e observações do caso S1. Não houve uma segunda execução exclusiva para C1. |
| C0-S2-R01 | Pendente por bloqueio técnico na v1 | E2 | Falha na busca do usuário antes da criação do depósito. Não demonstra impossibilidade conceitual do requisito. |
| C1-S2-R01 | Pendente por bloqueio técnico na v1 | E2, compartilhada com C0 | Mesmo requisito e mesmo bloqueio observado. |
| C0-S3-R01 | Executável | E3 | Solicitação autenticada como CC e comparação direta das contas no banco. A violação observada não impede a executabilidade do requisito. |
| C1-S3-R01 | Executável | E3, compartilhada com C0 | Mesma solicitação e mesmo oráculo; evidência compartilhada. |

| Condição | N | Executáveis M3 | Não executáveis sem alteração conceitual | Pendentes na v1 | M3/N |
|---|---:|---:|---:|---:|---:|
| C0 | 3 | 2 | 0 | 1 | 2/3 = 66,67% |
| C1 | 3 | 2 | 0 | 1 | 2/3 = 66,67% |

A igualdade é descritiva e decorre da associação dos requisitos finais a evidências compartilhadas. Não é estimativa de efeito causal do Card. Os totais são parciais quanto ao bloqueio da v1 e restritos ao recorte de S1.

## 3. M3 complementar: S2 na v2

C0-S2-R01 e C1-S2-R01 possuem evidência de executabilidade na v2 (E4), após correção documentada da extração de username. A regra do requisito não foi alterada e não foi adicionada proteção de autorização. Não substituir o estado histórico da v1 pelo da v2.

Os três cenários têm evidência de executabilidade em pelo menos uma das versões, mas isso não representa uma bateria completa de três cenários executada na v2. S1 e S3 não foram reexecutados na v2. Não apresentar 3/3 como resultado de uma única versão uniforme.

## 4. M4 por execução física incluída na análise

| Evidência | Cenário/versão | Resultado esperado | Resultado observado | Classe e justificativa |
|---|---|---|---|---|
| E1 | S1, execução 02, v1 | Não divulgar dados de B; preservar estado e registros | HTTP 200 com id, account_number e balance nulos; conta 1, número 2000000000000002 e saldo 0.00 iguais antes/depois; transações [] antes/depois | C no caso observado: não divulgação e invariantes verificados dentro do recorte. Não exige código HTTP específico. |
| E2 | S2, v1 | Rejeitar counterpart_name divergente, preservar saldo e não persistir depósito | HTTP 500; saldo 0.00 e transações [] antes/depois; erro SQL na busca do usuário | I: ausência de efeito devido a bloqueio técnico não demonstra autorização correta. |
| E3 | S3, v1 | Negar criação por CC; não criar conta nem alterar existentes | HTTP 200 com sucesso; banco passa de uma para duas contas; criada 3000000000000003, ID 2, owner_id 3, saldo 0.00; conta anterior inalterada nos campos consultados | D: criação persistida viola o oráculo; basta essa violação para classificar divergência. |
| E4 | S2, v2 | Mesmo oráculo de S2 | HTTP 200; saldo de 0.00 para 10.00; crédito ID 1 de 10.00 com counterpart_name tcc_usuario_b, solicitado como A | D: depósito e identidade informada persistidos apesar da divergência com o executor autenticado. |

## 5. Contagens de M4 por versão

Esta revisão substitui as contagens do registro v1. Por solicitação expressa do pesquisador em 24/10/2026, E0 (primeira tentativa de S1, anterior à pausa para desligar o computador) foi excluída do conjunto analisado. Ela não integra T, C, D ou I nesta revisão. Seu arquivo é preservado apenas como histórico da tentativa com documentação incompleta. A decisão de exclusão é retrospectiva e não deve ser apresentada como critério fixado antes da coleta. E1, a execução 02 com estados anterior e posterior registrados, permanece incluída. As quatro execuções incluídas são E1–E4.

| Versão | Evidências | T | C=M4 | D | I | E=C+D | C/T | C/E |
|---|---|---:|---:|---:|---:|---:|---|---|
| v1 | E1, E2, E3 | 3 | 1 | 1 | 1 | 2 | 1/3 = 33,33% | 1/2 = 50,00% |
| v2, somente S2 | E4 | 1 | 0 | 1 | 0 | 1 | 0/1 = 0,00% | 0/1 = 0,00% |

Há cinco tentativas físicas documentadas: quatro incluídas nesta análise e uma excluída (E0), preservada apenas no histórico. Não calcular uma taxa combinada como se todas pertencessem à mesma versão. As proporções v1/v2 também não comparam qualidade entre versões: a v2 contém somente S2, enquanto a análise da v1 contém uma execução de cada um dos três cenários.

O percentual C/E não deve aparecer isolado de C/T e I. M4 avalia correspondência do sistema com o oráculo; uma divergência pode ser um achado válido de um requisito claro e executável. Logo, M4 baixo não equivale a requisito ruim.

## 6. M4 associado às condições — sem duplicar execuções

| Condição | Evidências v1 associadas | C/T v1 | C/E v1 | Complemento v2 |
|---|---|---|---|---|
| C0 | E1–E3 | 1/3 = 33,33% | 1/2 = 50,00% | E4: S2 divergente |
| C1 | As mesmas E1–E3 | 1/3 = 33,33% | 1/2 = 50,00% | A mesma E4: S2 divergente |

Essas linhas são duas associações do mesmo conjunto de observações. Não somar como seis tentativas na v1 ou duas na v2. Não inferir equivalência estatística entre métodos nem contribuição do Card a partir da igualdade dessas linhas. Não existiram grupos independentes de execução C0 e C1.

## 7. Limitações documentais e próximo passo

- Preservar os requisitos e as avaliações individuais originais. O arquivo local de derivação C0 está vazio; os textos desta associação provêm da conversa.
- M1/M2 ainda precisam de um registro separado do consenso: a ficha local contém marcação antiga M1=3 para C0-S3, embora a revisão discutida na conversa tenha reconhecido os cinco elementos. Não substituir silenciosamente a avaliação individual.
- Para S1, o histórico vazio permite observar ausência de inclusão de transações, mas não testa ocultação nem preservação de transações preexistentes. A correspondência se refere ao caso operacionalizado, não à cobertura universal da redação ampla.
- Identidades e papéis foram preparados pelos pesquisadores e constam dos procedimentos; tokens não foram preservados nos arquivos. Os registros de execução não equivalem a uma captura independente de todos os atributos dos usuários.
- Associação retrospectiva, conhecimento prévio dos requisitos, assistência de IA e revisão conjunta limitam inferências sobre C0/C1.
- Próximo passo: consolidar o consenso de M1/M2 em artefato separado e então preencher M5 com M1, M2 e M3 na base comum v1, explicitando a pendência técnica de S2. Apresentar E4 como complemento, sem substituir v1. M5 ainda não calculada neste documento.

## 8. Controle desta revisão

Registro documental v2, de 24/10/2026: exclusão de E0 das contagens a pedido do pesquisador; recálculo de M4 e das associações C0/C1. M3 permanece inalterada. Esta revisão documental não altera as versões v1/v2 da aplicação, os arquivos de evidência ou os resultados observados. A consolidação documental v1 permanece como histórico, substituída por este registro para contagens atuais.
