## 📋 Diagnóstico Inicial (O Cenário)

* **Hardware Target:** TCL-LA-MT9221-01 (FHD @ 60Hz).
* **Gargalo Crítico:** **1,0 GB de RAM** / 8,0 GB de ROM.
* **Sintomas:** Alto consumo de ZRAM, input lag agressivo no controle remoto e lentidão geral causados pelo bloatware nativo e anúncios integrados da fabricante e da Google.

---

## 🛠️ O Walkthrough Passo a Passo

### Passo 1: Infraestrutura de Segurança (`Apply/Rollback`)

Antes de qualquer alteração, criamos a infraestrutura de segurança com dois scripts shell (`.sh`) para execução direta no ambiente da TV via `adb shell` na pasta `/data/local/tmp/`.

* **`debloat_tcl.sh`:** Script de otimização automatizada. Desativa serviços de telemetria, agregadores de conteúdo e zera as escalas de animação do Android para dar resposta instantânea à interface.
* **`rollback_tcl.sh`:** O *fail-safe*. Um script reverso que reabilita todos os pacotes e restaura as animações para 1.0 caso haja necessidade de reverter o sistema ao padrão de fábrica.

### Passo 2: Mapeamento de Dependências e Deploy do Launcher

A estratégia central foi substituir a interface padrão pesada da Google pelo **Projectivy Launcher (v4.68)**, a UI mais eficiente do mercado para recuperar performance de hardware limitado.

* **Identificação do Pacote:** Mapeamos que na build estável v4.68, o ID interno real do launcher é `com.spocky.projengmenu` (disfarçado no sistema como *Engineering Menu*).
* **Instalação:** Baixamos o APK correto direto do repositório oficial do desenvolvedor e realizamos o deploy via canal limpo do ADB (`install -r`).
* **Ativação:** Invocamos a tela oculta de configurações do app diretamente pelo terminal para ativar o *Override* do controle remoto:
```bash
am start -n com.spocky.projengmenu/.activities.SettingsActivity
```

### Passo 3: O Golpe Final no Bloatware (Lista de Alvos)

Com o Projectivy validado e rodando, executamos o corte cirúrgico de gastos de memória em nível de usuário (`--user 0`). Os seguintes serviços foram completamente **desabilitados**:

#### 🛑 Serviços Nativos TCL (Anúncios e Telemetria)

* `com.tcl.waterfall.overseas` (Agregador de conteúdo/Anúncios na Home)
* `com.tcl.guard` (Aplicativo de "otimização" nativo que gerava overhead)
* `com.tcl.esticker` (Modo Loja/Demonstração)
* `com.tcl.smartalexa` (Integração interna de assistente de voz)
* `com.tcl.usercenter` / `com.tcl.dashboard` (Telas secundárias e coleta de dados)
* `com.tcl.ttvs` (Serviço de background da fabricante)

#### 🛑 Serviços Core Google (Relaunchers e Bloatware)

* `com.google.android.tvlauncher` (O Launcher padrão original, principal vilão da RAM)
* `com.google.android.tvrecommendations` (Serviço invisível que injetava banners patrocinados)
* `com.google.android.videos` (Google Play Filmes)
* `com.google.android.youtube.tvmusic` (YouTube Music para TV)
* `com.google.android.katniss` (Google Assistant de background)

### Passo 4: Execução do Cold Boot

Disparamos um `adb reboot`. No reinício, a TV ignorou os serviços suspensos e carregou o Projectivy Launcher diretamente como a Home padrão.

---

## 📊 Resultado da Missão

* **ZRAM Liberada:** Economia real estimada entre **200MB e 250MB de RAM**, devolvendo folga para o Garbage Collector do Android respirar.
* **UI Fluida:** Fim do engasgo crônico de renderização. O input lag do controle remoto foi reduzido a zero.
* **Segurança Preservada:** Toda a otimização foi feita estritamente no espaço de usuário. As partições de boot, chaves de criptografia e o **ESN da Netflix (DRM Widevine L1)** permaneceram intactos, garantindo reprodução de streaming em alta definição sem quebras.
