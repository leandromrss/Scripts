# Define o caminho do log
$logPath = "C:\Logs\Status_Hardware.log"

# Cria a pasta de logs se não existir
if (!(Test-Path "C:\Logs")) { New-Item -ItemType Directory -Path "C:\Logs" }

# Obtém a data e hora atual
$dataHoraExecucao = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Obtém o uso do processador
$cpuUsage = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average

# Obtém a memória total e disponível
$mem = Get-CimInstance Win32_OperatingSystem
$memTotal = [math]::Round($mem.TotalVisibleMemorySize / 1MB, 2)
$memFree = [math]::Round($mem.FreePhysicalMemory / 1MB, 2)
$memUsed = $memTotal - $memFree
$memUsagePercent = [math]::Round(($memUsed / $memTotal) * 100, 2)

# Obtém informações da bateria (se for notebook)
$battery = Get-CimInstance Win32_Battery
$batteryStatus = if ($battery) { 
    "Status: $($battery.BatteryStatus), Ciclos: $($battery.DesignCapacity), Saude: $($battery.EstimatedChargeRemaining)%" 
} else { 
    "Sem bateria detectada" 
}

# Obtém informações do disco
$disks = Get-PhysicalDisk | Select-Object DeviceID, MediaType, HealthStatus, OperationalStatus, Size
$diskInfo = @()

foreach ($disk in $disks) {
    $deviceID = $disk.DeviceID
    $mediaType = $disk.MediaType
    $healthStatus = $disk.HealthStatus
    $status = $disk.OperationalStatus
    $size = [math]::Round($disk.Size / 1GB, 2)

    # Obtém vida útil do SSD via WMIC
    $smartData = wmic diskdrive get status | Select-String "OK"

    if ($smartData) {
        $ssdHealth = "Boa"
    } else {
        $ssdHealth = "Falha detectada ou sem suporte SMART"
    }

    # Adiciona ao relatório (com ${} para interpolação correta)
    $diskInfo += "Disco ${deviceID}: ${mediaType} | Saude: ${healthStatus} | Status: ${status} | Tamanho: ${size} GB | Vida util: ${ssdHealth}"
}

# Monta o relatório
$report = @"
======================================
 Relatorio de Saude do Sistema
======================================
Data/Hora da Execucao: ${dataHoraExecucao}
CPU: ${cpuUsage}% Uso
Memoria RAM: ${memUsed} GB / ${memTotal} GB (${memUsagePercent}%)
Bateria: ${batteryStatus}
Informacoes do Disco:
$($diskInfo -join "`n")
======================================
"@

# Salva o relatório no arquivo de log
$report | Out-File -FilePath $logPath -Encoding utf8 -Append


