# Caminho do log
$logPath = "C:\Logs\Controle_Processos.log"

# Cria a pasta de logs se não existir
if (!(Test-Path "C:\Logs")) { New-Item -ItemType Directory -Path "C:\Logs" }

# Obtém a data e hora atual
$dataHoraExecucao = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Obtém a lista de processos e calcula CPU manualmente
$processos = Get-Process | Select-Object Name, Id, PM, StartTime, @{Name="CPU_Usage"; Expression={
    $before = $_.CPU
    Start-Sleep -Milliseconds 500
    $after = (Get-Process -Id $_.Id -ErrorAction SilentlyContinue).CPU
    if ($after -and $before) {
        [math]::Round($after - $before, 2)
    } else {
        0
    }
}}

# Obtém a lista de tarefas agendadas ativas
$tasks = Get-ScheduledTask | Where-Object { $_.State -eq "Running" } | Select-Object TaskName, State

# Formata os processos para exibição
$processInfo = $processos | ForEach-Object {
    "Processo: $($_.Name) | ID: $($_.Id) | CPU: $($_.CPU_Usage)% | Memoria: $([math]::Round($_.PM / 1MB, 2)) MB | Iniciado em: $($_.StartTime)"
}

# Formata as tarefas agendadas
$taskInfo = $tasks | ForEach-Object {
    "Tarefa: $($_.TaskName) | Estado: $($_.State)"
}

# Gera o relatório
$report = @"
======================================
 Relatorio de Controle de Processos e Tarefas
======================================
Data/Hora da Execucao: ${dataHoraExecucao}

Processos em Execucao:
$($processInfo -join "`n")

Tarefas Agendadas Ativas:
$($taskInfo -join "`n")

======================================
"@

# Salva o relatório no log
$report | Out-File -FilePath $logPath -Encoding utf8 -Append

# Exibe a saída no Tactical RMM
Write-Output "$report"