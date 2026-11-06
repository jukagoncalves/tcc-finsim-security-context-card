# Comparação descritiva M5 — v1

Organizada em 24/10/2026 com assistência de IA. Base: consenso_M1_M2_v1.md, consolidacao_M3_M4_v2.md e rastreabilidade_requisitos_execucoes_v1.md. As condições têm três requisitos cada. Resultados dos textos finais com associação retrospectiva a evidências compartilhadas; não são grupos independentes.

## 1. Cálculo principal

Para cada medida comparável, delta = valor C1 menos valor C0. Usam-se valores exatos nas contas; arredondamento somente na apresentação. M1 é resumida pela média na escala 0–5. Diferenças de proporções são expressas em pontos percentuais (p.p.). Não somar dimensões em escore único.

| Medida | C0 | C1 | Delta C1−C0 |
|---|---|---|---|
| Média M1 | 15/3 = 5,00 | 15/3 = 5,00 | 0,00 ponto da escala |
| M2 — proporção de claros | 3/3 = 100% | 3/3 = 100% | 0 p.p. |
| M3 — proporção executável na v1 | 2/3 = 66,67% | 2/3 = 66,67% | 0 p.p. |

M3 na v1: em cada condição há 2 executáveis no recorte observado, 0 comprovadamente não executáveis sem alteração conceitual e 1 pendente por bloqueio técnico. Esse resultado permanece parcial quanto a S2, mesmo havendo uma execução complementar na v2.

## 2. Detalhamento por cenário

Cada célula C0/C1 abaixo contém um requisito em cada condição (N=1).

| Cenário | M1 C0 / C1 | Delta M1 | M2 C0 / C1 | Delta M2 | M3 v1 C0 / C1 | Delta M3 |
|---|---|---|---|---|---|---|
| S1 | 5 / 5 | 0 | 1/1 / 1/1 | 0 p.p. | 1/1 / 1/1 | 0 p.p. |
| S2 | 5 / 5 | 0 | 1/1 / 1/1 | 0 p.p. | 0/1 / 0/1, ambos pendentes | 0 p.p., parcial |
| S3 | 5 / 5 | 0 | 1/1 / 1/1 | 0 p.p. | 1/1 / 1/1 | 0 p.p. |

O 0/1 em S2 representa ausência de comprovação de executabilidade na v1 por bloqueio técnico; não representa impossibilidade conceitual. S1 é executável/correspondente no caso observado, sem generalização para históricos preexistentes.

## 3. M4 como informação complementar

Na v1, o conjunto físico incluído é E1, E2 e E3: T=3, C=1, D=1, I=1, E=2. Logo, C/T=1/3=33,33% e C/E=1/2=50%. E0 foi excluída das contagens por decisão do pesquisador durante a consolidação, com preservação histórica e registro dessa decisão retrospectiva.

| Condição associada | C/T v1 | C/E v1 | Natureza da associação |
|---|---|---|---|
| C0 | 1/3 = 33,33% | 1/2 = 50% | E1–E3 |
| C1 | 1/3 = 33,33% | 1/2 = 50% | As mesmas E1–E3 |

A diferença descritiva em ambas as proporções é zero. Não há seis execuções físicas na v1. A igualdade resulta de evidências compartilhadas e não demonstra efeito do Card sobre o comportamento da aplicação. M4 avalia aderência ao oráculo, não qualidade do requisito.

E4, S2 na v2: executável após correção técnica, com resultado divergente (saldo aumentado e counterpart_name de B persistido em solicitação de A). Para essa execução complementar, T=1, C=0, D=1, I=0. Não substituir E2 por E4 na tabela v1 nem apresentar o conjunto S1/v1 + S2/v2 + S3/v1 como bateria integral da v2. Não comparar taxas v1/v2 como melhoria de segurança: os cenários executados diferem.

## 4. Interpretação

Não foi observada diferença nas medidas consolidadas de completude, clareza e executabilidade entre os requisitos finais associados a C0 e C1. Esse resultado é descritivo, limitado aos três cenários e ao processo efetivamente realizado. M1 atingiu o máximo em todos os requisitos, de modo que a rubrica de presença não distingue diferenças adicionais de detalhamento. M2 reflete o consenso informado, não um novo julgamento independente.

Os resultados não permitem concluir que o Security Context-Card melhorou os requisitos, tampouco que é inútil ou equivalente à apresentação convencional em outros contextos. Os pesquisadores conheciam os cenários e os requisitos, houve assistência de IA e revisão conjunta, e as evidências de execução foram associadas retrospectivamente às duas condições. Os textos finais de S2/S3 são idênticos entre condições. Essas características limitam a atribuição de diferenças, ou de sua ausência, ao Card.

A contribuição observável do trabalho está na aplicação documentada do processo: explicitação de políticas e oráculos, organização dos requisitos, rastreabilidade e identificação de divergências de autorização em relação às políticas adotadas. Não atribuir causalmente essas atividades ao Card sem evidência comparativa própria.

## 5. Pendências para redação final

1. Integrar esta comparação à seção de resultados e discutir as limitações acima, distinguindo planejamento de procedimento efetivamente realizado.
2. Consolidar os textos finais das listas de derivação com indicação de sua origem na conversa; não preencher retroativamente primeiras versões como se fossem registros contemporâneos independentes.
3. Vincular os arquivos desta consolidação como apêndices ou material complementar e preservar as avaliações individuais e evidências originais.
4. Não declarar concluída a revisão integral da monografia ou cumprimento de todas as exigências institucionais com base apenas nesta consolidação.