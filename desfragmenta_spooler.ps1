# ================================
# 1. DESFRAGMENTAÇÃO DE TODOS OS DISCOS
# ================================
Write-Output "🔄 Iniciando desfragmentação de discos..."

$discos = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' }

foreach ($disco in $discos) {
    try {
        Write-Output "Desfragmentando unidade $($disco.DriveLetter):..."
        defrag "$($disco.DriveLetter):" /U /V
    } catch {
        Write-Output "Erro ao desfragmentar $($disco.DriveLetter): $_"
    }
}

# ================================
# 2. REINICIAR O SPOOLER DE IMPRESSÃO
# ================================
Write-Output "`n🖨️ Reiniciando o serviço de spooler de impressão..."

try {
    Stop-Service -Name "Spooler" -Force
    Start-Sleep -Seconds 2
    Start-Service -Name "Spooler"
    Write-Output "Spooler reiniciado com sucesso."
} catch {
    Write-Output "Erro ao reiniciar o spooler: $_"
}

# ================================

Write-Output "`n✅ Tarefas concluídas!"
