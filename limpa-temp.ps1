#Comando de remoção de arquivo temporário
Remove-Item $Env:temp -Recurse -Force

#Mensagem de conclusão
Write-Output "Arquivos temporarios removidos com sucesso"