
# Caminho do log
$logPath = "C:\Logs\Windows_Update.log"
 
# Cria a pasta de logs se não existir
if (!(Test-Path "C:\Logs")) { New-Item -ItemType Directory -Path "C:\Logs" }
 
# Obtém a data e hora atual
$dataHoraExecucao = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
 
# Registra início do processo
Write-Output "[$dataHoraExecucao] Iniciando o Windows Update..." | Out-File -FilePath $logPath -Encoding utf8 -Append
 
# Ativa o serviço do Windows Update
sc.exe config wuauserv start= auto
net start wuauserv
 
# Verifica se o serviço foi iniciado corretamente
Start-Sleep -Seconds 5
$servicoStatus = Get-Service -Name wuauserv
if ($servicoStatus.Status -ne "Running") {
    Write-Output "[$dataHoraExecucao] ERRO: Servico Windows Update nao iniciou corretamente." | Out-File -FilePath $logPath -Encoding utf8 -Append
    exit 1
}
 
# Força a busca por atualizações
Write-Output "[$dataHoraExecucao] Buscando atualizacoes disponiveis..." | Out-File -FilePath $logPath -Encoding utf8 -Append
 
try {
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $updateSearcher = $updateSession.CreateUpdateSearcher()
    $searchResult = $updateSearcher.Search("IsInstalled=0")
} catch {
    Write-Output "[$dataHoraExecucao] ERRO: Falha ao buscar atualizacoes." | Out-File -FilePath $logPath -Encoding utf8 -Append
    exit 1
}
 
if ($searchResult.Updates.Count -gt 0) {
    Write-Output "[$dataHoraExecucao] Encontradas $($searchResult.Updates.Count) atualizações. Iniciando instalação..." | Out-File -FilePath $logPath -Encoding utf8 -Append
   
    # Criar coleção de atualizações
    $updateCollection = New-Object -ComObject Microsoft.Update.UpdateColl
    foreach ($update in $searchResult.Updates) {
        $updateCollection.Add($update) | Out-Null
    }
   
    # Instalar as atualizações
    $updateInstaller = New-Object -ComObject Microsoft.Update.Installer
    $updateInstaller.Updates = $updateCollection
    $installationResult = $updateInstaller.Install()
   
    Write-Output "[$dataHoraExecucao] Instalacao finalizada com status: $($installationResult.ResultCode)" | Out-File -FilePath $logPath -Encoding utf8 -Append
} else {
    Write-Output "[$dataHoraExecucao] Nenhuma atualizacao disponivel no momento." | Out-File -FilePath $logPath -Encoding utf8 -Append
}
 
# Verifica se há reinicialização pendente
$rebootPending = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
if ($rebootPending) {
    Write-Output "[$dataHoraExecucao] Um reinicio do sistema e necessario." | Out-File -FilePath $logPath -Encoding utf8 -Append
    Restart-Computer -Force
} else {
    Write-Output "[$dataHoraExecucao] Atualizacoes concluídas sem necessidade de reinicio." | Out-File -FilePath $logPath -Encoding utf8 -Append
}