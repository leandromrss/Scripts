# Scripts de Automação e Manutenção

Este repositório contém uma coleção de scripts PowerShell para automação e manutenção de sistemas Windows.

## 📋 Scripts de Manutenção do Sistema

### 🧹 Limpeza e Otimização
- **limpa-chace.ps1**: Script para limpeza de cache do sistema
- **limpa-temp.ps1**: Script para limpeza de arquivos temporários
- **Desfragmenta_Spooler_RemoveApp.ps1**: Script para desfragmentação do spooler de impressão e remoção de aplicativos

### 🔄 Atualizações
- **windows-update.ps1**: Script para gerenciamento de atualizações do Windows
- **atualiza-winget 1.ps1**: Script para atualização do gerenciador de pacotes Winget

## 📊 Scripts de Monitoramento

### 🖥️ Monitoramento de Hardware
- **coleta-vida-hardware.ps1**: Script para coleta de informações sobre vida útil do hardware
- **coleta-processos-e-tarefas.ps1**: Script para monitoramento de processos e tarefas do sistema

### 🔍 Análise de Sistema
- **coletor-de-criticidade.ps1**: Script para análise de criticidade do sistema
- **valida-usuarios.ps1**: Script para validação de usuários do sistema

## 🔒 Scripts de Segurança

### 🔐 VPN e Acesso
- **checklist-vpn.ps1**: Script para verificação de configurações de VPN

## 📢 Scripts de Notificação
- **notifica-ballon.ps1**: Script para envio de notificações via balão do Windows

## 🖨️ Script de Desfragmentação do Spooler

### desfragmenta_spooler.ps1

Este script realiza as seguintes operações:

1. **Desfragmentação do Spooler de Impressão**
   - Para o serviço de spooler
   - Limpa a fila de impressão
   - Reinicia o serviço
   - Verifica o status do serviço


2. **Funcionalidades Adicionais**
   - Geração de logs detalhados
   - Verificação de permissões
   - Tratamento de erros
   - Notificações de status

### Requisitos Específicos
- Permissões de administrador
- Serviço de spooler de impressão instalado
- Acesso ao registro do Windows

### Observações Importantes
- Faça backup antes de executar
- Verifique os logs após a execução
- Pode requerer reinicialização do sistema

## 🛠️ Requisitos

- Windows 10 ou superior
- PowerShell 5.1 ou superior
- Permissões de administrador (para a maioria dos scripts)

## ⚠️ Observações Importantes

- Execute os scripts com permissões de administrador quando necessário
- Faça backup do sistema antes de executar scripts de modificação
- Verifique os logs gerados por cada script
- Alguns scripts podem requerer configurações específicas do ambiente

## 📝 Logs e Monitoramento

Cada script gera seus próprios logs:
- Logs de execução
- Logs de erro
- Logs de sucesso
- Métricas de performance

## 🔧 Personalização

Os scripts podem ser personalizados de acordo com as necessidades específicas:
- Ajuste de parâmetros
- Modificação de caminhos
- Configuração de intervalos
- Definição de critérios específicos 
