# 🤝 Guia de Contribuição

Primeiro, obrigado pelo interesse em contribuir! Este projeto é mantido por uma pessoa só, então toda ajuda é bem-vinda.

## Estrutura do Projeto

Cada modelo de TV tem sua **própria pasta** na raiz do repositório:

```
lorotv/
├── tcl/                      # Scripts para a TV TCL de referência
│   ├── debloat_tcl.sh
│   └── rollback_tcl.sh
|   └── hardware_specs.md          # Especificações da TV de referência
├── install_projectivity.ps1  # Script genérico (pode funcionar em vários modelos)
```

## 📂 Como adicionar sua TV

### 1. Crie uma pasta com o nome da sua TV

Escolha um nome curto e descritivo, de preferência o fabricante em minúsculas:

```
samsung/
philips/
lg/
xiaomi/
```

> **Importante:** não use espaços, acentos ou caracteres especiais no nome da pasta.

### 2. Se a pasta já existir, verifique o modelo exato

Digamos que você tenha uma **Samsung TU8000** e já exista uma pasta `samsung/`. Dentro dela, veja se o script existente é para o **mesmo modelo** que o seu:

- **Mesmo fabricante, mesmo modelo** → apenas melhore o que já está escrito: corrija comentários, adicione mais pacotes, sugira melhorias.
- **Mesmo fabricante, modelo diferente** → crie uma subpasta com o modelo:

  ```
  samsung/
  ├── tu8000/
  │   ├── debloat.sh
  │   └── rollback.sh
  └── ──────────────────  ←  aq1i você adiciona:
  └── ru7100/
      ├── debloat.sh
      └── rollback.sh
  ```

  O motivo: mesmo dentro do mesmo fabricante, versões de firmware e chipsets variam. Um pacote que existe na sua TV pode não existir em outra.

### 3. Conteúdo esperado dentro da pasta

Mínimo desejável:

| Arquivo | Obrigatório? | Descrição |
|---|---|---|
| `debloat.sh` | ✅ Sim | Script para desativar bloatware |
| `rollback.sh` | ✅ Sim | Script para reverter o debloat |
| `hardware.md` | 👍 Recomendado | Especificações da sua TV (copie o `hardware_specs.md` como template) |

### 4. Regras para os scripts

- **Use `pm disable-user`**, nunca `pm uninstall` — isso mantém a reversão possível sem reset de fábrica
- Teste o rollback antes de abrir o PR
- Comente os pacotes explicando o que cada um faz (se você não sabe, coloque "função desconhecida" mesmo — alguém pode complementar depois)
- Mantenha o mesmo formato dos scripts existentes para consistência

## 💡 "É o mesmo modelo, o que eu faço?"

Se sua TV é exatamente o mesmo modelo de uma pasta já existente:

- Adicione pacotes que o script original pode ter deixado passar
- Corrija comentários errados
- Atualize versões de firmware/hardware se diferente
- Sugira novos blocos de otimização (ex: desativar animações, ajustar governador de CPU, etc.)

Não existe contribuição pequena. Um único pacete desativado pode ser o suficiente para desafogar 128 MB de ZRAM em outra TV igual à sua.

## 🚀 Abrindo um Pull Request

1. Faça um fork do repositório
2. Crie um branch com o nome da sua TV: `git checkout -b add-samsung-tu8000`
3. Commit suas alterações: `git commit -m "feat: add Samsung TU8000 scripts"`
4. Push: `git push origin add-samsung-tu8000`
5. Abra um Pull Request explicando:
   - Modelo da TV
   - Versão do firmware/Android
   - O que os scripts fazem
   - Se você testou e por quanto tempo

## ❓ Dúvidas

Abra uma [issue](https://github.com/anomalyco/lorotv/issues) com suas dúvidas. Lembre-se: este projeto é mantido nos tempos livres, então resposta pode demorar — e nem sempre vou conseguir ajudar com modelos que não tenho acesso para testar.
