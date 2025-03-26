# Verifica se o script está rodando como Administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Se não estiver como Administrador, reinicia o script com privilégios elevados
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Executa a atualização do Winget sem pedir confirmação
winget upgrade --all --silent --accept-source-agreements

# Exibe uma mensagem informando que a atualização foi concluída
Write-Output "✅ Todas as atualizações foram concluídas!"