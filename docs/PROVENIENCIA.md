# Proveniência e integridade

Pacote de publicação preparado em 05/11/2026 a partir da pasta TCC dos pesquisadores. As duas aplicações, configurações originais, evidências e documentos copiados foram preservados byte a byte. O manifesto `manifesto_publicacao.json` registra tamanho e SHA-256 dos arquivos originais incluídos, com caminhos relativos ao repositório.

Os arquivos `.env` de v1 e v2 foram omitidos por conterem credenciais locais. Não existem volumes MySQL nem imagens Docker exportadas neste pacote: o ambiente é descrito por Dockerfile, Compose e dependências fixadas. Os estados observados foram preservados em JSON. Não houve nova execução de S1, S2 ou S3 durante a preparação do repositório.

Os manifestos históricos `manifesto_api.json`, `manifesto_correcao.json` e `preparacao_c0_c1_v1/manifesto_fontes.json` permanecem originais. Podem conter caminhos do computador de coleta ou hashes de arquivos de preparação. Esses caminhos são registros de origem, não pré-requisitos para instalar o repositório. Os hashes históricos de `.env` não dão acesso aos valores omitidos. A conferência de publicação usa o manifesto novo; as datas históricas não foram retroativamente substituídas.

O clone local do FinSim utilizado na coleta não contém metadados Git que permitam afirmar um commit original. Sua identidade é documentada pelos hashes dos módulos preservados, não por um commit presumido da versão atual no GitHub. O código-fonte original de referência é https://github.com/cmu-sei/finsim.

Por definição de escopo dos pesquisadores, todos os PDFs, modelos BPMN, imagens e demais arquivos de composição da monografia foram excluídos da publicação. O conjunto público contém os ambientes, evidências, políticas, materiais C0/C1, registros GQM e documentação para consulta e reprodução. As exclusões ocorreram somente na cópia preparada para publicação; os materiais de origem permanecem no computador dos pesquisadores.

Foram acrescentados README, guias, modelos `.env.example`, utilitários e manifesto para facilitar a consulta e a preparação local. Eles não representam procedimentos registrados contemporaneamente à coleta. A presença de assistência de IA nesses materiais de organização não é ocultada.

Verificação: `powershell -NoProfile -File .\scripts\verificar_integridade.ps1` na raiz. A configuração `.gitattributes` impede conversões automáticas de fim de linha, preservando os hashes depois de clonar.
