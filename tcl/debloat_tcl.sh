#!/system/bin/sh

# =====================================================================
# L.O.R.O-TV - debloat_tcl.sh (The Hunter)
# =====================================================================
# O que este script faz?
#   Desativa (disable) pacotes de bloatware de TVs TCL Android
#   e reduz animações do sistema para zero.
#
# Por que desativar e não desinstalar?
#   - Sem root: 'pm disable-user' funciona sem privilégios root
#   - Reversível: o APK continua no sistema, só fica invisível
#   - Seguro: não corrompe partição do sistema
#
# Como usar?
#   No PC: adb push debloat_tcl.sh /data/local/tmp/
#          adb shell /system/bin/sh /data/local/tmp/debloat_tcl.sh
#
# Conceitos:
#   - 'pm' = Package Manager, gerenciador de pacotes do Android
#   - 'disable-user' = desativa para o usuário atual (ID 0 = dono)
#   - 'settings put global' = altera configurações do sistema Android
# =====================================================================

echo "=== L.O.R.O-TV: Iniciando Desativação de Bloatware ==="
echo ""

# --------------------------------------------------------------------
# BLOCO 1: Bloatware da TCL
# --------------------------------------------------------------------
# Cada linha abaixo usa 'pm disable-user' seguido do nome do pacote.
# O formato do nome do pacote é 'com.fabricante.nomedoapp'.
# O '--user 0' indica que a desativação é para o usuário principal.
# --------------------------------------------------------------------

echo "[TCL] Desativando Waterfall (feed de anúncios)..."
pm disable-user --user 0 com.tcl.waterfall.overseas

echo "[TCL] Desativando Guard (segurança/scan)..."
pm disable-user --user 0 com.tcl.guard

echo "[TCL] Desativando eSticker (figurinhas)..."
pm disable-user --user 0 com.tcl.esticker

echo "[TCL] Desativando Smart Alexa (assistente)..."
pm disable-user --user 0 com.tcl.smartalexa

echo "[TCL] Desativando User Center (central do usuário)..."
pm disable-user --user 0 com.tcl.usercenter

echo "[TCL] Desativando Dashboard (painel TCL)..."
pm disable-user --user 0 com.tcl.dashboard

echo "[TCL] Desativando TTVS (recomendações TV)..."
pm disable-user --user 0 com.tcl.ttvs

echo ""
echo "[OK] Bloatware TCL desativado."

# --------------------------------------------------------------------
# BLOCO 2: Bloatware da Google
# --------------------------------------------------------------------
# A Google também pré-instala vários apps que consomem recursos.
# O Google Assistant na TV chama-se 'Katniss' (codinome interno).
# --------------------------------------------------------------------

echo ""
echo "[Google] Desativando Google Play Filmes..."
pm disable-user --user 0 com.google.android.videos

echo "[Google] Desativando YouTube Music TV..."
pm disable-user --user 0 com.google.android.youtube.tvmusic

echo "[Google] Desativando Katniss (Google Assistant)..."
pm disable-user --user 0 com.google.android.katniss

echo "[Google] Desativando Recomendações da TV..."
pm disable-user --user 0 com.google.android.tvrecommendations

echo ""
echo "[OK] Bloatware Google desativado."

# --------------------------------------------------------------------
# BLOCO 3: Desativar animações do sistema
# --------------------------------------------------------------------
# O Android usa 'settings' para gerenciar configurações globais.
# 'put global' define um valor no namespace global (aplica a todos
# os usuários). As três chaves abaixo controlam a escala das
# animações de janela, transição e duração de animadores.
#
# Valor padrão é 1.0 (animação em tempo real).
# Valor 0 desliga completamente a animação.
# --------------------------------------------------------------------

echo ""
echo "[UI] Desativando animações para resposta instantânea..."

settings put global window_animation_scale 0
settings put global transition_animation_scale 0
settings put global animator_duration_scale 0

echo "[OK] Animações zeradas."

# --------------------------------------------------------------------
# Finalização
# --------------------------------------------------------------------
echo ""
echo "=============================================="
echo "  L.O.R.O-TV: Debloat concluído!"
echo "  Recomenda-se reiniciar a TV: adb reboot"
echo "=============================================="
