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
