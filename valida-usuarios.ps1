# Obtém todos os usuários locais
$usuarios = Get-WmiObject Win32_UserAccount | Select-Object Name, FullName, LocalAccount

# Exibe os usuários encontrados
if ($usuarios) 
{
    Write-Output "Usuarios encontrados na maquina:"
    $usuarios | ForEach-Object { Write-Output "$($_.Name) - Conta Local: $($_.LocalAccount)" }
    exit 0
}
 else 
{
    Write-Output "Nenhum usuário encontrado."
    exit 1
}