# 📋 Especificações de Hardware — TV de Referência

> ⚠️ **DISCLAIMER IMPORTANTE**
>
> **Não recomendo que você mexa na sua TV.** Este projeto foi feito para *minha* TV específica (TCL com chipset MediaTek MT9221). Os scripts desativam pacotes do sistema — se algo der errado, você pode perder funcionalidades ou até deixar a TV instável.
>
> Se tiver dúvidas sobre o projeto em si, fique à vontade para **abrir uma issue** no repositório. Posso tentar ajudar, **mas apenas para a minha configuração de hardware/software**. Outros modelos, fabricantes ou versões de sistema podem ter comportamentos completamente diferentes — nesses casos, infelizmente não vou conseguir ajudar.

---

## 🔧 Especificações

| Componente | Detalhe Técnico | Observação |
|---|---|---|
| **Fabricante / ID** | `TCL-LA-MT9221-01` | Plataforma baseada em chipset **MediaTek MT9221** |
| **ID do Projeto** | `1283` | Identificador de SKU da build da TCL |
| **Arquitetura** | `armv7l` (32-bit) | Kernel SMP PREEMPT (compilado em Nov/2025) |
| **Resolução Nativa** | 1920×1080 @ 60Hz | Full HD (FHDTV) |
| **Memória RAM** | 1,0 GB | **O gargalo principal do sistema** (motivação do projeto) |
| **Armazenamento** | 8,0 GB (ROM) | Espaço limitado para partição de dados (`/data`) |

## 📦 Versões de Software

| Componente | Versão |
|---|---|
| **Produto** | `V8-T221T01-LF1V622.000807` |
| **TV+ OS** | `V5.2.0 (V8-2504240-MF1V520)` |
| **Kernel Linux** | `4.19.116+ #2 SMP PREEMPT Thu Nov 6 17:36:24 CST 2025 armv7l` |

---

## 💡 Notas Técnicas

- **MT9221** — Chipset MediaTek voltado para TVs entry-level/mid-range com foco em custo-benefício. Não possui suporte a 64-bit, o que limita o desempenho em apps modernos.
- **1 GB de RAM** — Este é o principal motivo do projeto. Com bloatware rodando, o ZRAM fica saturado e a TV engasga até para abrir configurações.
- **Kernel PREEMPT** — O kernel foi compilado com preempção, o que teoricamente melhora a responsividade em tarefas interativas... quando há RAM livre.
- **Armazenamento de 8 GB** — Na prática, o usuário tem acesso a ~4–5 GB para apps. Cada APK de bloatware removido (mesmo que só desativado) ajuda.
