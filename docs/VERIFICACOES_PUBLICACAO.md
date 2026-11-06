# Verificações do pacote de publicação

Data: 05/11/2026. Verificações locais da preparação do repositório; não são novos resultados dos cenários.

- Integridade SHA-256: 80 arquivos originais copiados sem alteração.
- Sintaxe Python: 20 arquivos analisados sem importar ou executar a aplicação.
- JSON: 26 arquivos lidos com sucesso.
- Diferença entre aplicações v1/v2: somente `app/finsim_trans/resources.py`, conforme `diferenca_v1_v2.diff`.
- Script de configuração: sintaxe conferida e geração local de `.env` para cada versão verificada.
- Configuração Compose: `docker compose config --quiet` concluído nas duas versões, sem iniciar serviços.
- Git: os dois `.env` gerados são ignorados; nenhum `.env` original foi copiado.
- Conferência dos materiais de origem: não foram encontrados JWTs, tokens GitHub, blocos de chave privada nem valores dos `.env` de coleta nos demais arquivos textuais e textos extraídos dos PDFs. Essa busca por padrões não é uma garantia universal de ausência de dados sensíveis.
- Nenhum cenário de teste, criação de usuário, depósito, criação de conta ou consulta ao banco experimental foi executado para preparar este pacote.
