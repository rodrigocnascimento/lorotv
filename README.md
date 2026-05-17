# 🐈‍⬛ L.O.R.O-TV 📺

**L**ow-resource **O**ptimization & **R**emote **O**rchestration for **TV**

<p align="center">
  <img src="header.png" alt="L.O.R.O-TV" width="420" height="620">
</p>

> "Porque se a TV tem 1GB de RAM, ela precisa da agilidade de um gato, não da lerdeza de um sistema cheio de ads."

Kit de ferramentas **DIY** para otimização de Smart TVs Android (foco **TCL/MediaTek**) via **ADB**. Remove bloatware, libera RAM e substitui o launcher padrão por um mais leve.

> [!CAUTION]
> **Não recomendo que ninguém que não saiba exatamente o que está fazendo utilize estes scripts.** Mexer em pacotes do sistema pode causar comportamentos inesperados na TV. Você assume todo e qualquer risco ao executar qualquer comando deste repositório. **Isento-me de toda e qualquer responsabilidade** por danos, perda de funcionalidades ou qualquer outro problema decorrente do uso deste material.
>
> Dito isso, os scripts foram feitos para serem o mais seguros possível: eles **apenas desativam** pacotes com `pm disable-user` — nada é desinstalado, nada é irreversível. Um `pm enable` ou um reset de fábrica restaura tudo ao normal.

---

## 📂 Estrutura

```
lorotv/
├── README.md
├── DOCUMENTATION.md           # Documentação detalhada e educativa
├── CONTRIBUTING.md            # Guia de contribuição
├── hardware_specs.md          # Especificações da TV de referência
├── header.png
├── LICENSE
├── install_projectivity.ps1  # Instala o Projectivy Launcher via ADB
└── tcl/
    ├── debloat_tcl.sh         # Desativa bloatware (roda na TV)
    ├── rollback_tcl.sh        # Reverte desativações
    └── WALKTHROUGH.md         # Passo a passo da otimização
```

---

## 🚀 Uso Rápido

```powershell
# Conecta na TV
adb connect IP_DA_TV:5555

# Copia e executa o debloat
adb push tcl/debloat_tcl.sh /data/local/tmp/
adb shell /system/bin/sh /data/local/tmp/debloat_tcl.sh

# (Opcional) Instalar Projectivy Launcher
.\install_projectivity.ps1

# Reinicia
adb reboot
```

Para reverter: `adb shell /system/bin/sh /data/local/tmp/rollback_tcl.sh`

---

## 📖 Documentação

Veja [DOCUMENTATION.md](DOCUMENTATION.md) para explicações detalhadas sobre ADB, cada pacote desativado, conceitos do PowerShell e Android.

---

## 📜 Licença

MIT — Feito com 🐾 por um desenvolvedor de Belém.
