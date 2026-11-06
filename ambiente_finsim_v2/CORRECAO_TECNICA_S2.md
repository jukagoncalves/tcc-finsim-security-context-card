# Correção técnica de S2 — versão 2
Preparada em 24/10/2026. Nenhum experimento executado durante a preparação.

Única alteração na aplicação: em BankDeposit.post, substituir
user = UserModel.find_by_username( get_jwt_identity() )
por
user = UserModel.find_by_username( get_jwt_identity()['username'] )

A busca passa a receber o nome do usuário. Nenhuma comparação com counterpart_name ou regra de autorização foi acrescentada. A ocorrência semelhante em BankWithdrawal foi preservada. Outros problemas do depósito podem persistir; devem ser diagnosticados e registrados antes de novas alterações. Os demais arquivos da aplicação são idênticos, conforme manifesto_correcao.json.

Projeto Compose: tcc-finsim-v2. Imagem: tcc-finsim-api:v2. API: http://127.0.0.1:5001.
O novo projeto usa seu próprio volume trans_data. O banco da v1 não é reutilizado nem modificado. O banco v2 inicia vazio; recriar A, B e a conta de B antes do teste e registrar novos estados anteriores e posteriores. Observar os IDs efetivos sem presumir equivalência com v1.
As credenciais locais de configuração foram copiadas; não publicar .env.
A versão 1 e suas evidências permanecem preservadas. A execução inconclusiva de S2 na v1 não deve ser substituída pela execução v2.

Próximo passo manual na pasta ambiente_finsim_v2:
docker compose up -d --build
docker compose ps

Construção e execução ainda pendentes de verificação. Após ambos os serviços ficarem healthy, preparar os dados sintéticos pela API v2 antes de testar.