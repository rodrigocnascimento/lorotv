<#
.SYNOPSIS
    L.O.R.O-TV — Instalação do Projectivy Launcher (v4.68)
    Baixa, instala e configura o Projectivy como launcher alternativo.

.DESCRIPTION
    Este script automatiza todo o fluxo de substituição do launcher
    padrão de uma TV Android TCL:
      1. Baixa o APK do Projectivy Launcher
      2. Conecta na TV via ADB
      3. Instala o APK
      4. Abre a tela de configurações do Projectivy na TV
      5. (após confirmação) Desativa o launcher original da Google
      6. Oferece reboot opcional

.NOTES
    Requer: adb.exe no mesmo diretório, TV com depuração USB ativada
    Autor: L.O.R.O-TV Team
#>

# ====================================================================
# CONFIGURAÇÕES — ajuste antes de executar
# ====================================================================

# Endereço IP da TV no formato "IP:PORTA"
# O Android Debug Bridge usa a porta 5555 por padrão para conexões TCP
$TV_IP = "IP_DA_SUA_TV:5555"

# Nome local do arquivo APK que será baixado
$APK_NAME = "Projectivy_Launcher_4.68.apk"

# URL oficial da versão 4.68 do Projectivy Launcher no GitHub
# O Invoke-WebRequest baixará deste link se o arquivo não existir
$DOWNLOAD_URL = "https://github.com/spocky/miproja1/releases/download/4.68/ProjectivyLauncher-4.68-c82-xda-release.apk"

# Nome real do pacote Android (identificador único do app)
# No Android, cada app tem um package name único, tipo um CPF do app
$PACKAGE_REAL = "com.spocky.projengmenu"

# ====================================================================
# INÍCIO DO SCRIPT
# ====================================================================

Write-Host "=== L.O.R.O-TV: Iniciando Deploy Corrigido (v4.68) ===" -ForegroundColor Cyan

# --------------------------------------------------------------------
# PASSO 1: Download do APK
# --------------------------------------------------------------------
# Test-Path verifica se o arquivo já existe no diretório atual.
# Se existir, pulamos o download para economizar banda.
# Invoke-WebRequest funciona como 'curl' no Linux.
# --------------------------------------------------------------------

if (-not (Test-Path $APK_NAME)) {
    Write-Host "[+] Baixando Projectivy Launcher v4.68 oficial..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile $APK_NAME
} else {
    Write-Host "[*] APK v4.68 já encontrado localmente." -ForegroundColor Green
}

# --------------------------------------------------------------------
# PASSO 2: Conexão ADB
# --------------------------------------------------------------------
# 'adb devices' lista todos os dispositivos conectados.
# Verificamos se o IP da TV aparece na lista.
# Se não estiver, tentamos reconectar com 'adb connect'.
# --------------------------------------------------------------------

Write-Host "[+] Verificando conexão com a TV ($TV_IP)..." -ForegroundColor Yellow
$devices = .\adb.exe devices
if ($devices -match $TV_IP) {
    Write-Host "[*] Conexão ADB ativa." -ForegroundColor Green
} else {
    Write-Host "[!] Reconectando à TV..." -ForegroundColor Magenta
    .\adb.exe connect $TV_IP | Out-Null
    # | Out-Null: suprime a saída do comando (não mostra no terminal)
}

# --------------------------------------------------------------------
# PASSO 3: Instalação do APK
# --------------------------------------------------------------------
# 'adb install -r' instala ou reinstala (-r = replace) o APK.
# O operador '@{}' captura a saída do comando na variável.
# Verificamos se a saída contém "Success" para confirmar.
# --------------------------------------------------------------------

Write-Host "[+] Transmitindo APK para a TCL..." -ForegroundColor Yellow
$installResult = .\adb.exe -s $TV_IP install -r .\$APK_NAME

if ($installResult -match "Success") {
    Write-Host "[*] APK instalado com sucesso no Android!" -ForegroundColor Green
} else {
    Write-Host "[X] Falha crítica na instalação: $installResult" -ForegroundColor Red
    # Exit encerra o script imediatamente com código de erro
    Exit
}

# --------------------------------------------------------------------
# PASSO 4: Abrir configurações do Projectivy na TV
# --------------------------------------------------------------------
# 'am start' = Activity Manager, inicia uma Activity no Android.
# Activity é como uma "tela" do app (ex: SettingsActivity).
# '-n' especifica o componente no formato 'pacote/.classe'.
# Isso abre o menu de configurações na TV para o usuário ativar
# a opção "Substituir Launcher Padrão".
# --------------------------------------------------------------------

Write-Host "[+] Invocando a tela de configurações do L.O.R.O-TV..." -ForegroundColor Yellow
.\adb.exe -s $TV_IP shell am start -n "$PACKAGE_REAL/.activities.SettingsActivity" | Out-Null

# --------------------------------------------------------------------
# PASSO 5: Aguardar confirmação do usuário
# --------------------------------------------------------------------
# Read-Host pausa o script e espera entrada do teclado.
# O usuário precisa olhar a TV e ativar manualmente a substituição
# do launcher padrão nas configurações do Projectivy.
# --------------------------------------------------------------------

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " ATENÇÃO: OLHE PARA A TELA DA SUA TV AGORA!               " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "1. O menu de configurações do Projectivy deve estar aberto."
Write-Host "2. Ative a opção 'Substituir Launcher Padrão' (Override)."
Write-Host ""

$confirm = Read-Host "Ajustou a configuração na TV e o controle está respondendo? (S/N)"

# --------------------------------------------------------------------
# PASSO 6: Desativar launcher stock (se confirmado)
# --------------------------------------------------------------------
# 'pm disable-user --user 0 <pacote>' desativa o launcher padrão.
# Com o launcher original desativado, o Android usa o Projectivy
# como launcher padrão na próxima inicialização.
# --------------------------------------------------------------------

if ($confirm.ToUpper() -eq "S") {
    Write-Host "[+] Aplicando Debloat no Launcher Stock da Google..." -ForegroundColor Yellow

    # Desativa o launcher original da Google TV
    .\adb.exe -s $TV_IP shell pm disable-user --user 0 com.google.android.tvlauncher

    # Desativa as recomendações da tela inicial (consome RAM)
    .\adb.exe -s $TV_IP shell pm disable-user --user 0 com.google.android.tvrecommendations

    Write-Host "[*] Limpeza concluída!" -ForegroundColor Green

    # --------------------------------------------------------------------
    # PASSO 7: Reboot opcional
    # --------------------------------------------------------------------
    # O reboot não é obrigatório, mas garante que o sistema carregue
    # o novo launcher desde o boot (cold boot effect).
    # --------------------------------------------------------------------

    $reboot = Read-Host "Deseja reiniciar a TV para aplicar o 'Cold Boot'? (S/N)"
    if ($reboot.ToUpper() -eq "S") {
        Write-Host "[+] Reiniciando hardware..." -ForegroundColor Cyan
        .\adb.exe -s $TV_IP reboot
        Write-Host "[*] Sistema reiniciado. L.O.R.O-TV operacional! 🐈‍⬛" -ForegroundColor Green
    }
} else {
    # Se o usuário respondeu N ou qualquer outra coisa, abortamos
    Write-Host "[X] Operação abortada de forma segura." -ForegroundColor Red
    # Nada foi alterado no sistema — o Projectivy está instalado
    # mas o launcher original continua ativo
}
