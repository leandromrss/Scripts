# Nome do software a verificar
$software = "FortiClient VPN"

# Caminhos do Registro onde softwares instalados são listados
$registryPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",  
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

# Verifica se o software está instalado
$installed = $false
foreach ($path in $registryPaths) 
{
    if (Get-ItemProperty -Path $path | Where-Object { $_.DisplayName -like "*$software*" }) 
    {
        $installed = $true
        break
    }
}

# Retorna o resultado para o Tactical RMM
if ($installed) 
{
    Write-Output "INSTALADO: O software '$software' foi encontrado."
    exit 0
} 
else 
{
    Write-Output "Que Pena!: O software '$software' NÃO foi encontrado."
    exit 1
}