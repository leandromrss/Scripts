# Desabilita erros visuais para execução mais limpa
$ErrorActionPreference = "SilentlyContinue"

# Detecta a unidade onde está o pendrive (baseado em um arquivo marcador)
$usbDrive = Get-PSDrive -PSProvider FileSystem | Where-Object {
    Test-Path "$($_.Root)\flag_usb.txt"
}

if ($usbDrive) {
    $driveLetter = $usbDrive.Root
    Write-Host "`nPendrive detectado em: $driveLetter`n" -ForegroundColor Cyan

    # Define o caminho da pasta onde estão os instaladores
    $appsPath = Join-Path -Path $driveLetter -ChildPath "Apps"

    # Lista de instaladores com argumentos opcionais
    $aplicativos = @(
        @{ Nome = "Adobe.exe"; Argumentos = "/silent" },
        @{ Nome = "AnyDesk.exe"; Argumentos = "/S" },
        @{ Nome = "ChromeSetup.exe"; Argumentos = "/silent" },
        @{ Nome = "winrar-x64-561br.exe"; Argumentos = "/S" },
        @{ Nome = "hdsentinel_pro_setup.exe"; Argumentos = "/S" }
    )

    # Executa cada instalador
    foreach ($app in $aplicativos) {
        $appPath = Join-Path -Path $appsPath -ChildPath $app.Nome
        if (Test-Path $appPath) {
            Write-Host "Instalando: $($app.Nome)..." -ForegroundColor Yellow
            Start-Process -FilePath $appPath -ArgumentList $app.Argumentos -Wait -NoNewWindow
            Write-Host "Finalizado: $($app.Nome)" -ForegroundColor Green
        } else {
            Write-Host "Não encontrado: $($app.Nome)" -ForegroundColor Red
        }
    }

    Write-Host "`nInstalação concluída." -ForegroundColor Cyan
} else {
    Write-Host "Pendrive com o arquivo 'flag_usb.txt' não foi encontrado." -ForegroundColor Red
}
