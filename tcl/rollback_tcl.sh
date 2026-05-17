#!/system/bin/sh

# =====================================================================
# L.O.R.O-TV - rollback_tcl.sh (The Nap)
# =====================================================================
# O que este script faz?
#   Reverte todas as alterações feitas pelo debloat_tcl.sh:
#   - Reativa todos os pacotes que foram desativados
#   - Restaura as animações do sistema para o valor padrão (1.0)
#
# Por que existe um rollback?
#   - Segurança: se algo quebrar na UI da TV, você recupera fácil
#   - Suporte técnico: antes de chamar a assistência, restaure tudo
#   - Teste: permite alternar entre modos otimizado e original
#
# Como usar?
#   No PC: adb push rollback_tcl.sh /data/local/tmp/
#          adb shell /system/bin/sh /data/local/tmp/rollback_tcl.sh
#
# Conceitos:
#   - 'pm enable' = reativa um pacote que foi desabilitado
#   - O Android mantém o estado de cada pacote em /data/system/packages.xml
#   - 'settings put global <chave> 1.0' restaura o comportamento original
# =====================================================================

echo "=== L.O.R.O-TV: Iniciando Rollback (Restauração) ==="
echo ""

# --------------------------------------------------------------------
# BLOCO 1: Reativar pacotes TCL
# --------------------------------------------------------------------
# O comando 'pm enable' faz o oposto de 'pm disable-user'.
# O pacote volta a funcionar normalmente como se nada tivesse
# acontecido — nenhum dado é perdido durante a desativação.
# --------------------------------------------------------------------

echo "[TCL] Reativando Waterfall (feed de anúncios)..."
pm enable com.tcl.waterfall.overseas

echo "[TCL] Reativando Guard..."
pm enable com.tcl.guard

echo "[TCL] Reativando eSticker..."
pm enable com.tcl.esticker

echo "[TCL] Reativando Smart Alexa..."
pm enable com.tcl.smartalexa

echo "[TCL] Reativando User Center..."
pm enable com.tcl.usercenter

echo "[TCL] Reativando Dashboard..."
pm enable com.tcl.dashboard

echo "[TCL] Reativando TTVS..."
pm enable com.tcl.ttvs

echo ""
echo "[OK] Pacotes TCL reativados."

# --------------------------------------------------------------------
# BLOCO 2: Reativar pacotes Google
# --------------------------------------------------------------------

echo ""
echo "[Google] Reativando Google Play Filmes..."
pm enable com.google.android.videos

echo "[Google] Reativando YouTube Music TV..."
pm enable com.google.android.youtube.tvmusic

echo "[Google] Reativando Katniss (Google Assistant)..."
pm enable com.google.android.katniss

echo "[Google] Reativando Recomendações da TV..."
pm enable com.google.android.tvrecommendations

echo ""
echo "[OK] Pacotes Google reativados."

# --------------------------------------------------------------------
# BLOCO 3: Restaurar animações do sistema
# --------------------------------------------------------------------
# O valor 1.0 = escala normal (100% da duração da animação).
# Isso restaura o comportamento padrão do Android Launcher.
# --------------------------------------------------------------------

echo ""
echo "[UI] Restaurando animações para o padrão (1.0)..."

settings put global window_animation_scale 1.0
settings put global transition_animation_scale 1.0
settings put global animator_duration_scale 1.0

echo "[OK] Animações restauradas."

# --------------------------------------------------------------------
# Finalização
# --------------------------------------------------------------------
echo ""
echo "=============================================="
echo "  L.O.R.O-TV: Rollback concluído!"
echo "  Todos os serviços originais foram reativados."
echo "=============================================="
