# Registro de preparação da API — 23/10/2026

## Escopo e estado

Cópia do componente bancário finsim-trans. Não são iniciados comerciantes, processadores de cartão ou frontend. As rotas do componente foram preservadas; somente S1/S2/S3 integram o estudo. Os pesquisadores iniciarão o ambiente. Não há resultados experimentais nesta preparação.

## Adaptações

1. Cópia dos módulos necessários em app/finsim_trans; resources.py, models.py, helper.py e views.py preservados byte a byte. A pasta baseline guarda os originais selecionados, e manifesto_api.json registra seus hashes.
2. O arquivo init_script.py do pacote continha apenas um caminho relativo. Na cópia de execução, ele foi substituído pelo conteúdo do init_script.py da raiz que esse caminho referencia. Isso restaura a importação esperada; seu bloco principal não é executado pela importação.
3. Conexão alterada de localhost para o serviço db e credencial de ambiente, com driver PyMySQL. Essa troca de driver deve ser registrada na metodologia, inclusive por possíveis diferenças de tratamento de erros/tipos.
4. Segredos Flask/JWT fornecidos por variáveis locais, sem alterar a estrutura da identidade, regras de expiração, papéis ou verificações de autorização.
5. Debug e recarga automática desativados. Execução via run.py, com publicação somente em 127.0.0.1:5000. Arquivo de diferenças acompanha as mudanças em __init__.py.
6. Python 3.8.20 e dependências fixadas para APIs legadas usadas pelo código; o README original menciona Python 3.6.5 e Flask 1.0.2. Não é uma reprodução exata do ambiente histórico. Requisitos fixados ainda precisam de confirmação por construção e inicialização; antes da coleta registrar a identificação final das imagens e pip freeze.
7. MySQL 8.0.27 e volume trans_data já preparados foram mantidos. Credenciais existentes do banco foram preservadas, acrescidas somente das novas chaves da API.

## Pontos deliberadamente ainda não corrigidos

BankDeposit continua buscando usuário com get_jwt_identity() inteiro, não converte explicitamente amount e confirma a transação antes do saldo. Nenhuma comparação entre counterpart_name e username foi adicionada. AccountCreation continua sem restrição por papel. GetAccountInfo mantém sua verificação de propriedade.

Se esses pontos impedirem executar um cenário, registrar o impedimento antes de decidir qualquer adaptação. Uma falha técnica não deve ser registrada como rejeição correta de autorização. Não corrigir políticas para produzir o resultado esperado do teste.

## Verificação desta preparação

Sintaxe dos arquivos Python verificada sem importar a aplicação, configuração Compose validada sem iniciar serviços e hashes de resources.py/models.py/helper.py/views.py conferidos. A saúde do banco foi informada pelos pesquisadores. A construção da imagem e a conexão da API ainda aguardam execução pelos pesquisadores. Nenhum usuário, conta ou depósito sintético foi criado nesta preparação.

## Referências técnicas consultadas

- API legada JWT 3.25.1: https://flask-jwt-extended.readthedocs.io/en/3.0.0_release/changing_default_behavior/
- Driver PyMySQL no SQLAlchemy 1.3: https://docs.sqlalchemy.org/en/13/dialects/mysql.html#pymysql

Preparação assistida por Codex. Manter o repositório original e o pacote de evidências anteriores para rastreabilidade.
