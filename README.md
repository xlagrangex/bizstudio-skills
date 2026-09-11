# Skill BizStudio

Le skill di Claude Code che usiamo in BizStudio. Oggi ce n'è una:

- **bizstudio-proposta** — genera una proposta commerciale scritta più il deck per la piattaforma delle presentazioni.

Il repo è privato. Contiene il corpus delle proposte reali già vinte, prezzi compresi: non condividerlo fuori da BizStudio.

---

## Installazione (la prima volta)

Serve un Mac con Claude Code già installato e funzionante.

Apri il Terminale e incolla questi comandi, uno alla volta.

Scarica il repo nella tua cartella utente:

```bash
git clone https://github.com/xlagrangex/bizstudio-skills.git ~/bizstudio-skills
```

Installa le skill dentro Claude Code:

```bash
cd ~/bizstudio-skills && ./installa.sh
```

Chiudi e riapri Claude Code. Scrivi `/bizstudio-proposta` e la skill parte.

---

## Aggiornare (quando Vincenzo cambia qualcosa)

Due comandi, sempre gli stessi:

```bash
cd ~/bizstudio-skills && git pull && ./installa.sh
```

Poi riavvia Claude Code.

---

## Come si usa la skill

Scrivi `/bizstudio-proposta` in Claude Code e mandagli tutto quello che hai sul
cliente: la trascrizione della call, le mail, il link al suo sito, appunti,
screenshot. Mandagli anche il logo del cliente, perché quello non se lo inventa.

Quando hai finito di mandargli materiale scrivi **vai**.

Da lì fa due cose in ordine. Prima scrive la proposta lunga in markdown, che è
il documento che il cliente può leggersi da solo. Te la fa vedere e la
correggi finché non ti convince. Solo quando la approvi costruisce il deck di
slide per la piattaforma.

Il deck vive nel repo `presentazioni-bizstudio`, che è un altro repo: per
lavorarci devi averlo clonato e avere accesso.

---

## Per chi mantiene le skill (Vincenzo)

La copia di lavoro è quella in `~/.claude/skills/`. Per pubblicare le modifiche:

```bash
cp -R ~/.claude/skills/bizstudio-proposta ~/bizstudio-skills/ \
  && cd ~/bizstudio-skills \
  && git add -A && git commit -m "aggiorna bizstudio-proposta" && git push
```
