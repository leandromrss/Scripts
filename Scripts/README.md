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


## 💾 Instalador via Pendrive (PowerShell)

Este script permite a instalação automatizada de softwares a partir de um pendrive, mesmo quando a letra da unidade varia entre máquinas (D:, E:, F:, etc.).

### 🔧 Funcionalidades principais

- **Detecção automática** da unidade do pendrive via arquivo marcador `flag_usb.txt`  
- **Instalação silenciosa** dos aplicativos (via `/S`, `/silent`, etc.)  
- **Alta flexibilidade** — basta adicionar novos instaladores no bloco de configuração

### 📁 Estrutura esperada no pendrive

<UNIDADE>:\
├── flag_usb.txt ← marcador (pode estar vazio)
├── instalar.ps1 ← script principal em PowerShell
├── instalar.bat ← atalho prático para usuários finais
└── Apps\ ← pasta com os instaladores
├── Adobe.exe
├── AnyDesk.exe
├── ChromeSetup.exe
├── winrar‑x64‑561br.exe
└── hdsentinel_pro_setup.exe


### ▶️ Como usar

1. Insira o pendrive.  
2. Clique com o botão direito em **`instalar.bat`** e selecione *"Executar como administrador"*.  
3. O script será executado automaticamente, identificando a letra da unidade e instalando os softwares listados.

### ✍️ Personalizando os aplicativos

Para adicionar ou remover instaladores, edite este trecho no `instalar.ps1`:

```powershell
$aplicativos = @(
    @{ Nome = "Adobe.exe";              Argumentos = "/silent" },
    @{ Nome = "AnyDesk.exe";            Argumentos = "/S" },
    @{ Nome = "ChromeSetup.exe";        Argumentos = "/silent" },
    @{ Nome = "winrar‑x64‑561br.exe";   Argumentos = "/S" },
    @{ Nome = "hdsentinel_pro_setup.exe"; Argumentos = "/S" }
)
```
Basta manter o nome exatamente igual ao do arquivo dentro da pasta Apps e ajustar o argumento conforme o instalador exige.

💡 Ideial para técnicos de TI, suporte e cenários de instalação em lote — leve, portátil e eficiente!

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
---

## 🔧 Personalização

Os scripts podem ser personalizados de acordo com as necessidades específicas:
- Ajuste de parâmetros
- Modificação de caminhos
- Configuração de intervalos
- Definição de critérios específicos 
