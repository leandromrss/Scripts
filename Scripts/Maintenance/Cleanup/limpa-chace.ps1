# Fecha navegadores antes da limpeza
$processosNavegadores = @("chrome", "msedge", "firefox")

foreach ($proc in $processosNavegadores) {
    Get-Process $proc -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            Stop-Process -Id $_.Id -Force
            Write-Output "Processo encerrado: $($_.ProcessName)"
        } catch {
            Write-Output "Falha ao encerrar: $($_.ProcessName)"
        }
    }
}

# Função para limpar conteúdo de uma pasta
function Clear-CacheFolder {
    param([string]$caminho)

    if (Test-Path $caminho) {
        try {
            Remove-Item "$caminho\*" -Recurse -Force -ErrorAction Stop
            Write-Output "Limpeza realizada: $caminho"
        } catch {
            Write-Output "Erro ao limpar: $caminho - $_"
        }
    } else {
        Write-Output "Caminho não encontrado: $caminho"
    }
}

# Lista de usuários com AppData acessível
$usuarios = Get-ChildItem "C:\Users" | Where-Object {
    Test-Path "C:\Users\$($_.Name)\AppData\Local"
}

foreach ($usuario in $usuarios) {
    $perfil = "C:\Users\$($usuario.Name)"

    # Chrome
    $chromeCache = "$perfil\AppData\Local\Google\Chrome\User Data\Default\Cache"
    $chromeGPUCache = "$perfil\AppData\Local\Google\Chrome\User Data\Default\GPUCache"
    $chromeCookies = "$perfil\AppData\Local\Google\Chrome\User Data\Default\Cookies"

    Clear-CacheFolder $chromeCache
    Clear-CacheFolder $chromeGPUCache

    if (Test-Path $chromeCookies) {
        try {
            Remove-Item $chromeCookies -Force
            Write-Output "Cookies removidos: Chrome"
        } catch {
            Write-Output "Erro ao remover cookies do Chrome: $_"
        }
    }

    # Edge
    $edgeCache = "$perfil\AppData\Local\Microsoft\Edge\User Data\Default\Cache"
    $edgeGPUCache = "$perfil\AppData\Local\Microsoft\Edge\User Data\Default\GPUCache"
    $edgeCookies = "$perfil\AppData\Local\Microsoft\Edge\User Data\Default\Cookies"

    Clear-CacheFolder $edgeCache
    Clear-CacheFolder $edgeGPUCache

    if (Test-Path $edgeCookies) {
        try {
            Remove-Item $edgeCookies -Force
            Write-Output "Cookies removidos: Edge"
        } catch {
            Write-Output "Erro ao remover cookies do Edge: $_"
        }
    }

    # Firefox
    $firefoxProfiles = "$perfil\AppData\Local\Mozilla\Firefox\Profiles"
    if (Test-Path $firefoxProfiles) {
        Get-ChildItem $firefoxProfiles | ForEach-Object {
            $cachePath = "$($_.FullName)\cache2"
            Clear-CacheFolder $cachePath

            $cookiesPath = "$($_.FullName)\cookies.sqlite"
            if (Test-Path $cookiesPath) {
                try {
                    Remove-Item $cookiesPath -Force
                    Write-Output "Cookies removidos: Firefox"
                } catch {
                    Write-Output "Erro ao remover cookies do Firefox: $_"
                }
            }
        }
    }
}

Write-Output "Limpeza de cache e cookies concluída com sucesso!"
