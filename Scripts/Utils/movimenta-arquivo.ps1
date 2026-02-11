# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    
    try {
        # Reexecuta o script com privilégios de administrador
        Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    } catch {
        Write-Error "Falha ao tentar executar como administrador. $_"
    }
    exit
}

# === CONFIGURAÇÕES ===
$origem = "C:\origem\arquivo.txt"
$destino = "C:\destino\arquivo.txt"

# Cria a pasta de destino se não existir
$destinoPasta = Split-Path -Path $destino
if (!(Test-Path -Path $destinoPasta)) {
    try {
        New-Item -ItemType Directory -Path $destinoPasta -Force | Out-Null
    } catch {
        Write-Error "Erro ao criar a pasta de destino: $_"
        exit
    }
}

# Move o arquivo, substituindo se já existir
try {
    Move-Item -Path $origem -Destination $destino -Force
    Write-Output "Arquivo movido com sucesso para $destino"
} catch {
    Write-Error "Erro ao mover o arquivo: $_"
}
