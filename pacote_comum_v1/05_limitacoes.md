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
