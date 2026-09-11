---
name: bizstudio-proposta
description: Crea proposte commerciali BizStudio in DUE deliverable coerenti da un brief leggero (conversazione/riassunto cliente + logo) — (1) una proposta scritta MD long-form ed esaustiva e (2) un deck per la piattaforma Next.js `presentazioni-bizstudio` (slides.json = array di HTML renderizzato da Deck.tsx, con deck.css e modalità Presenta/PDF). Da invocare con "/bizstudio-proposta" quando l'utente vuole creare una nuova proposta/preventivo per un cliente. Material-first: estrae il brief dal materiale fornito, riempie i buchi con domande mirate, poi scrive prima l'MD (fonte) e ne deriva il deck. La Soluzione è il capitolo a profondità massima. Brandfetch solo per i loghi dei servizi; logo cliente fornito dall'utente.
---

# BizStudio Proposta

Genera, da un brief leggero, **due artefatti coerenti**:

1. **Proposta scritta MD** (`<cliente>-proposta.md`) — long-form, esaustiva, prosa. La **fonte narrativa**: il cliente la legge da solo.
2. **Deck** per la piattaforma `presentazioni-bizstudio` — `presentations/<slug>-slides.json` (array di stringhe HTML) renderizzato da `Deck.tsx`, con `app/deck.css` e modalità Presenta + PDF.

**Regola d'oro del flusso**: prima si scrive l'MD (master), poi se ne **deriva** il deck. L'MD può essere prolisso — Vincenzo presenta le proposte dal vivo, quindi la profondità è un valore, non un difetto.

Questa skill è **standalone**. Non dipende da `bizstudio-presentazioni`. Incorpora le regole che le servono e punta ai file reali della piattaforma e al corpus di referenze.

---

## File della skill (leggi quando servono)

- **[MD_PATTERN.md](MD_PATTERN.md)** — scheletro della proposta scritta + lineage delle 5 proposte di riferimento + come articolare la Soluzione granulare. Leggi in **Fase 1**.
- **[DECK_PATTERNS.md](DECK_PATTERNS.md)** — vocabolario `deck.css`, Brandfetch, sistema di animazione, come derivare il deck dall'MD, come estendere il CSS con mockup bespoke. Leggi in **Fase 2**.
- **[references/proposte-vinte/](references/proposte-vinte/)** — corpus testuale delle proposte reali. È il lignaggio che rende la voce BizStudio riconoscibile. **Rivedi sempre tutto il corpus e apri la/e referenza/e più vicine per settore e formato prima di scrivere:**
  - `nawave.md` — servizio professionale premium, offerta singola €2.000, conversione indiretta, lead magnet + blog *(gold)*
  - `bht-srl.md` — energetico/fotovoltaico-smart home, blog + preventivatore + tabella comparativa
  - `kruz-shop.md` — e-commerce (migrazione), forte focus SEO/continuità
  - `active-medical-center.md` — sanità/centro medico multi-specialista, registro istituzionale/fiducia, 2 tier (€800/€1.500)
  - `andrea-onde-durto.md` — sanità/landing terapia, 3 tier (€1.200/€650/€850), sezione materiali
  - `visevis.md` — agenzia comunicazione B2B, 3 tier (€650/€950/€1.350), portfolio
  - `antica-roccia-calascio.md` — turismo/ospitalità, offerta singola €1.000, prenotazioni + multilingua
  - `zapa-shoes.md` — e-commerce retail, offerta singola €2.900, listino funzionalità standard
  - `bp-techno-ritech.md` — e-commerce ricondizionati (narrativa, no tier)
  - `manzo-luxury-car.md` — noleggio auto luxury (narrativa, no tier)
  - `gv-jewelry.md` — e-commerce gioielleria artigianale di lusso + B2B, offerta singola, configuratore/personalizzazione 3D
- **[references/deck-gold-nawave.md](references/deck-gold-nawave.md)** — anatomia del deck gold Nawave (29 slide) + puntatori a `slides.json` e `deck.css`.

## Dove vive cosa (target operativo)

| Artefatto | Posizione |
|---|---|
| Proposta scritta MD | `presentazioni-bizstudio/docs/<slug>-proposta.md` (o `bizstudioastro/docs/` se l'utente preferisce — **chiedi al primo uso**) |
| Deck JSON | `presentazioni-bizstudio/presentations/<slug>-slides.json` |
| Registrazione deck | `presentazioni-bizstudio/presentations/registry.ts` |
| Asset deck (logo cliente, screenshot, loghi servizi) | `presentazioni-bizstudio/public/<slug>/` |
| CSS condiviso (da NON riscrivere, eventualmente estendere) | `presentazioni-bizstudio/app/deck.css` |
| Renderer (da NON toccare) | `presentazioni-bizstudio/components/Deck.tsx` |
| PDF | `npm run pdf` nella piattaforma (Puppeteer) |

La skill **opera dentro `presentazioni-bizstudio`** per il deck. Se non sei in quella cartella, chiedi conferma del path (default: `../presentazioni-bizstudio` rispetto a `bizstudioastro`).

---

## Principi non-negoziabili (la voce BizStudio)

1. **Audience = hero, BizStudio = guida.** Il cliente è "tu/voi", il protagonista. Mai vantarsi ("abbiamo 10 anni di esperienza") più di quanto si parli del cliente.
2. **Titolo = takeaway concreto**, mai label. "Sito + 4 preventivatori. 5 settimane." non "La soluzione". Leggi solo i titoli → capisci la proposta.
3. **AS-IS / TO-BE esplicito.** Sempre una coppia Situazione attuale ↔ desiderata.
4. **Assertion + evidence**, mai muri di bullet. Ogni affermazione ha un visual che la sostiene (nel deck) o un paragrafo che la spiega (nell'MD).
5. **Proiezione di valore consulenziale.** Regala idee/spunti/mini-analisi specifici per il cliente *prima* della firma. Lo "spunto BizStudio" 💡 è la firma della casa.
6. **Lettera personale** in apertura dell'MD ("Caro [Nome]…").
7. **Prolisso è ok nell'MD**, denso e visivo nel deck. Stesso contenuto, due registri.
8. **Privacy clienti**: MAI nominare altri clienti BizStudio nel deck di un cliente nuovo. I case study mostrati sono solo quelli forniti dall'utente.

---

## Workflow

### Fase 0 — Brief (material-first) · NON saltare

**Mai iniziare la stesura senza via libera esplicita.**

#### 0a · Chiedi il materiale
Apri così: *"Mandami quello che hai sul cliente — una conversazione, un riassunto, una trascrizione call, mail, link al suo sito — **e il logo del cliente** (lo carichi tu, non lo prendo da internet). Quando hai finito di mandarmi roba, scrivi 'vai'."*

Fonti accettate: URL siti, PDF/DOCX/PPT, immagini/screenshot, audio/trascrizioni, copia-incolla di chat/mail, conversazioni con altri AI, brand book, note vocali.

#### 0b · Estrai il brief dal materiale
Mentre processi il materiale, **estrai** (non chiedere se è già deducibile):

| Campo | Note |
|---|---|
| Cliente + referenti (nomi) | per la lettera "Caro X" e i "prossimi passi" |
| Settore | tara linguaggio ed esempi |
| Scope offerta | single/multi-service, one-shot/retainer |
| Pricing range | se assente → `[da definire]` |
| Buyer persona | founder / CMO / CEO… |
| Tono | consulenziale / operativo / visionario / diretto |
| Deadline / urgenza | per lo sconto a scadenza |
| Fase relazione | prima call / trattativa / closing |

#### 0c · Riempi i buchi (solo quelli) con `AskUserQuestion`
Non rifare tutto il questionario: chiedi **solo i campi mancanti o ambigui**, a scelta multipla, max 4 per round.

#### 0d · Valida i fatti ambigui
Nomi propri, brand, cifre, date estratti da audio/OCR/trascrizioni vanno marcati `[da confermare]` e confermati prima dell'uso. Esempio:
> *"Ho estratto: founder Alessandro [da confermare], pricing €2.500 [da confermare], deadline 4 aprile [da confermare]. Confermi o correggi?"*

#### 0e · Livello tecnico del cliente
Classifica **avanzato / intermedio / non-tecnico** dal lessico del materiale e adatta il linguaggio (acronimi spiegati o evitati per i non-tecnici; niente over-spiegazioni per gli avanzati; mai condescending). Scrivilo nella sintesi e chiedi conferma.

#### 0f · Sintesi pre-stesura + via libera
Sintesi 5-10 righe (cliente, settore, scope, pricing, materiali, vincoli, livello tecnico). Poi: *"Confermi? Scrivi 'vai' e parto con l'MD."* Solo dopo il "vai" → Fase 1.

#### 0g · Consulta il corpus (sempre)
**Rivedi ogni volta tutte le referenze in `references/proposte-vinte/`** (elenco con tag settore/formato nella sezione "File della skill"). Individua la/e più vicina/e per settore *e* formato (offerta singola vs tier A/B/C, servizio vs e-commerce, narrativa vs strutturata) e riusane struttura e voce. Annuncia quale/i stai usando come riferimento.

---

### Fase 1 — Proposta scritta MD (la fonte)

Leggi **[MD_PATTERN.md](MD_PATTERN.md)** e scrivi `docs/<slug>-proposta.md`.

- Segui lo scheletro come **linea guida flessibile** (sezioni omettibili se non applicabili).
- La **Soluzione è il cuore**: moduli numerati con sotto-bullet granulari. **Nessuna compressione** — è qui che l'MD batte il deck in dettaglio.
- Tier A/B **solo se lo scope lo giustifica** (es. one-page vs multi-pagina).
- Investimento: listino + offerta scontata con deadline + tranche di pagamento.
- **Review con l'utente**: mostra l'MD, raccogli feedback, itera. L'MD approvato è il contratto narrativo da cui nasce il deck.

**Gate**: non passare al deck finché l'utente non approva l'MD.

---

### Fase 2 — Deck (derivato dall'MD)

Leggi **[DECK_PATTERNS.md](DECK_PATTERNS.md)**. Genera il deck PER LA PIATTAFORMA.

1. **Setup**: scegli lo `slug` (kebab-case del cliente). Crea `public/<slug>/`. Salva lì il logo cliente.
2. **Loghi servizi (Brandfetch)**: per i tool/stack citati (Astro, Sanity, Vercel, Brevo, GA4, Meta, TikTok, Cal.com…) scarica i loghi via Brandfetch e **salvali in locale** in `public/<slug>/` (gli inline `<script>` NON girano in `dangerouslySetInnerHTML`, quindi niente fallback runtime: i loghi vanno locali). Vedi DECK_PATTERNS §Brandfetch.
3. **Slide**: costruisci l'array di stringhe HTML usando il vocabolario `deck.css`. **Deriva ogni sezione dall'MD approvato.** La Soluzione si espande in più slide (1+ per modulo) con **mockup bespoke + spunto 💡**.
4. **Scrivi** `presentations/<slug>-slides.json` (array JSON di stringhe) e aggiungi l'entry in `registry.ts`.
5. **Mockup bespoke**: se un modulo richiede un mockup custom, estendi `deck.css` con classi **prefissate** (`<slug>-…` o `m<n>-…`) per non collidere.
6. **Preview**: `npm run dev` → `localhost:3001/<slug>`. Controlla scroll + modalità Presenta.
7. **Audit** (checklist sotto) → fix → itera con l'utente.

---

### Fase 3 — PDF (piattaforma)
Quando approvato: `npm run pdf` genera `public/<slug>.pdf` (Puppeteer, regole `@media print` già in `deck.css`). Deploy gestito dalla piattaforma (Vercel).

---

## Checklist audit deck (pre-show)

- [ ] **9 tappe narrative** coperte: attenzione · problema (AS-IS/TO-BE) · soluzione · proiezione valore · come funziona · prove · come lavoriamo/tempi · prezzo · next step
- [ ] Tutti i **titoli sono takeaway concreti**, non label
- [ ] **Soluzione a profondità massima**: 1+ slide per modulo, ognuna con mockup/visual dominante + spunto 💡 (niente muri di testo)
- [ ] **AS-IS/TO-BE** presente (slide `sd` rosso/verde)
- [ ] **Logo cliente** in cover + chiusura; **loghi servizi locali** (no immagini rotte)
- [ ] Almeno **4-5 slide su ~consistenti** con asset visivo dominante
- [ ] **3 background** rappresentati (dark/grad/light), mai monotonia
- [ ] **Palette fissa**: bianco/nero + Gradient B (magenta→arancio) in foreground; gradient 3-colori solo nei blob ambient; **niente colore brand cliente**
- [ ] **Divider numerati** uniformi (bg-grad + numero/titolo bianchi, word-mask)
- [ ] **Prezzo** bianco pieno, peso visivo massimo, slide dedicata (`offercard`/`pay`)
- [ ] **Spunto 💡** presente nei moduli soluzione + slide "Oltre il brief"
- [ ] **Livello tecnico** del testo coerente col cliente
- [ ] **No menzioni** ad altri clienti BizStudio; case study solo da materiali forniti
- [ ] **Fatti `[da confermare]`** tutti confermati prima di entrare nel deck
- [ ] Preview OK su `/<slug>` in scroll **e** in modalità Presenta
- [ ] `registry.ts` aggiornato (slug, title, client, subtitle, date, cover, slides)
