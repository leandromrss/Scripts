# Define o caminho do log
$logPath = "C:\Logs\Eventos_Criticos.log"

# Cria a pasta de logs se não existir
if (!(Test-Path "C:\Logs")) { New-Item -ItemType Directory -Path "C:\Logs" }

# Obtém os 20 últimos eventos críticos do Log do Sistema
$eventos = Get-EventLog -LogName System -EntryType Error, Warning -Newest 20

# Verifica se há eventos
if ($eventos) 
{
    # Formata a saída para melhor visualização
    $saida = $eventos | ForEach-Object 
    { 
        "[$($_.TimeGenerated)] [$($_.EntryType)] [$($_.Source)] $($_.Message)`n"
    }
    
    # Salva os eventos no arquivo de log
    $saida | Out-File -FilePath $logPath -Encoding utf8 -Append
    Write-Output "Os eventos criticos foram salvos em $logPath"
}
else 
{
    Write-Output "Nenhum evento critico encontrado."
}
