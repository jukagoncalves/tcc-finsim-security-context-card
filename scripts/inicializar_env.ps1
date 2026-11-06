[CmdletBinding()]
param([Parameter(Mandatory=$true)][ValidateSet('v1','v2')][string]$Versao)
$ErrorActionPreference = 'Stop'
$raizRepo = Split-Path -Parent $PSScriptRoot
$destinoEnv = Join-Path $raizRepo "ambiente_finsim_$Versao/.env"
if (Test-Path -LiteralPath $destinoEnv) {
    throw 'O arquivo .env já existe. Ele não será sobrescrito.'
}
$gerador = [System.Security.Cryptography.RandomNumberGenerator]::Create()
try {
    $linhas = foreach ($nome in @('FINSIM_DB_PASSWORD','FINSIM_ROOT_PASSWORD','FINSIM_APP_SECRET','FINSIM_JWT_SECRET')) {
        $bytes = New-Object byte[] 32
        $gerador.GetBytes($bytes)
        $valor = ([System.BitConverter]::ToString($bytes)).Replace('-', '').ToLowerInvariant()
        "$nome=$valor"
    }
    [System.IO.File]::WriteAllLines($destinoEnv, [string[]]$linhas, [System.Text.UTF8Encoding]::new($false))
} finally { $gerador.Dispose() }
Write-Output "Configuração local criada para $Versao. Nenhum serviço ou experimento foi iniciado."
