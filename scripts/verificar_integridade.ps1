$ErrorActionPreference = 'Stop'
$raizRepo = Split-Path -Parent $PSScriptRoot
$manifesto = Get-Content -Raw -LiteralPath (Join-Path $raizRepo 'docs/manifesto_publicacao.json') | ConvertFrom-Json
$falhas = @()
foreach ($registro in $manifesto.arquivos) {
    $caminho = Join-Path $raizRepo $registro.arquivo
    if (-not (Test-Path -LiteralPath $caminho -PathType Leaf)) {
        $falhas += "Ausente: $($registro.arquivo)"
    } elseif ((Get-FileHash -LiteralPath $caminho -Algorithm SHA256).Hash.ToLowerInvariant() -ne $registro.sha256) {
        $falhas += "Divergente: $($registro.arquivo)"
    }
}
if ($falhas.Count -gt 0) { $falhas | Write-Output; exit 1 }
Write-Output "Integridade confirmada: $($manifesto.arquivos.Count) arquivos originais preservados."
