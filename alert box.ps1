# Texto da notificação
$mensagem = "Atenção! Estamos sem acesso a internet!."

# Função para exibir a notificação
Function Show-BalloonTip 
{
    param 
    (
        [string]$message,
        [string]$title = "Aviso Importante"
    )

    # Criação do objeto de notificação
    $balloon = New-Object -ComObject WScript.Shell
    $balloon.Popup($message, 60, $title, 0x0)  # 10 segundos para o pop-up e 0x0 estilo do popup
}

# Chama a função para enviar a notificação
Show-BalloonTip -message $mensagem
