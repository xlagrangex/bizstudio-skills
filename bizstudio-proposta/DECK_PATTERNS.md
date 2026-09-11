# DECK_PATTERNS — Il deck per la piattaforma

Il deck NON è HTML self-contained: è **dati per la piattaforma `presentazioni-bizstudio`**.
Le slide *sono* HTML (craft per-slide preservato), ma vivono nel guscio React che dà navigazione, transizioni e PDF.

**Riferimento canonico**: il deck gold `presentations/nawave-slides.json` (29 slide) + `app/deck.css`. Leggi `references/deck-gold-nawave.md` e, quando serve la resa esatta di una scheda, apri `deck.css` e copia il markup dalle slide Nawave.

---

## Come funziona la piattaforma (cosa devi produrre)

1. **`presentations/<slug>-slides.json`** = array JSON di **stringhe HTML**. Ogni stringa = una slide.
2. **`presentations/registry.ts`** = entry che registra il deck:
   ```ts
   { slug, title, client, subtitle, date, cover: "/<slug>/<cover>.png", slides: <slug>Slides as string[] }
   ```
   (importa il JSON in cima e aggiungilo all'array `presentations`).
3. **`public/<slug>/`** = asset (logo cliente, screenshot, loghi servizi locali).
4. `components/Deck.tsx` renderizza ogni stringa con `dangerouslySetInnerHTML`, in due modi:
   - **scroll** (`.deck-scroll .frame`): contenuti "a transizioni finite" (già visibili).
   - **Presenta** (`.present-slide`, fullscreen): le animazioni a comparsa partono perché `Deck` rimonta la slide con `key={idx}`.
   - auto-numera i `.pagenum`.
5. **NON toccare** `Deck.tsx`. **NON riscrivere** `deck.css`: usalo, eventualmente estendilo (vedi §Mockup bespoke).

> ⚠️ Gli inline `<script>` dentro le stringhe HTML **non vengono eseguiti** (`dangerouslySetInnerHTML`). Niente JS per slide: animazioni e interazioni sono **già in `deck.css`**, attivate dalle classi giuste.

---

## Anatomia di una slide

```html
<div class="frame">
  <div class="slide bg-dark">
    <div class="blob"></div><div class="vign"></div>
    <div class="pad">
      <div class="eyebrow grad">1 · La Home</div>
      <div class="title">La prima schermata che converte</div>
      <!-- contenuto: cards / spec / twocol / mockup … -->
      <div class="spunto"><span class="b">💡</span><span class="t"><b>Spunto BizStudio —</b> …</span></div>
      <img class="brand-ft" src="/<slug>/bizstudio-logo.png" alt="BizStudio">
      <div class="pagenum"></div>
    </div>
  </div>
</div>
```

Regole base: `.blob`+`.vign` su ogni slide dark/light; `.pad` è il contenitore centrato; `.eyebrow` e `.title` sono posizionati assoluti in alto (tranne su `cover`/`index`); `.brand-ft` watermark in basso a sx; `.pagenum` auto-numerato.

---

## Vocabolario `deck.css` (le schede)

### Background & palette
- `bg-dark` (default, `#08070b` + blob ambient) · `bg-grad` (gradient magenta→arancio, per divider/hero) · `bg-light` (`#f3f1ea`, reset visivo).
- Palette **fissa**: `--blue #1B4088` · `--magenta #A51B80` · `--orange #DA5713`. Gradient 3-colori SOLO nei blob ambient; **Gradient B** (`--gradB`, magenta→arancio) per ogni elemento foreground (accent, dot, text-clip `.g`, ctabtn). **Niente colore brand cliente.**
- Alternanza: mai monotonia, tutti e 3 i background rappresentati in un deck lungo.

### Struttura / cornice
- `cover` — apertura: titolo grande, eyebrow, footer. `index` — table of contents (`idx`/`idxhead`/`idxh2`).
- `divider` — capitolo: `chapter-eyebrow` + `chapter-num` (gigante) + `chapter-title`, con `word`/`word>span` per l'animazione word-mask. Sfondo `bg-grad`. Numerali (01, 02…) e uniformi.
- `pad` · `eyebrow`(`.grad`) · `title`(`.big`, `.g` per text-clip) · `lede` · `pagenum` · `brand-ft` · `spacer` · `row`.

### Contenuto
- `cards` + `c2`/`c3`/`c5` → `card` (con `.k` numero cerchiato, `.ico` icona, `h4`, `p`).
- `spec` — lista brief (`li` con `b` lead, bullet gradient).
- `spunto` 💡 — box consulenziale (`.b` emoji + `.t` testo, `b` in grassetto). **La firma BizStudio.**
- `twocol` — due colonne (testo + visual).
- `sd` (situazione) — split AS-IS/TO-BE: `.sd-split` > `.sd-left` (dark+rosso, eyebrow `⚠️`) / `.sd-right` (verde, `🎯`), con `.sd-box` (`b`+`span`).
- `chi` — "Chi è BizStudio": `chi-title`/`chi-logo`/`chi-body`/`chi-line`/`chi-reviews`/`chi-portfolio` (layout assoluto).
- `stepflow` > `bigstep` (`.n`/`h4`/`p`) + `bigarr` — approccio in N stadi.
- `flow` > `fbox` + `farr` — flusso/automazioni con loghi.
- `browser` (`.bar`/`.url`/`.vp` + skeleton `.sk`,`.sk.hero`,`.sk.line`,`.skrow`) — mockup UI.
- `formmock` (multi-step) · `popup` (lead magnet) · `vidgrid`/`vid` (video).
- `cmp` — comparativa (`.r`/`.head`/`.us`/`.them`/`.yes`/`.no`).
- `tl`/`tlp` — timeline orizzontale (`.ic`/`.day`/`h4`/`p`/`.appr`) + `promise`.
- `offercard` (pricing) — `.tag-tr`, `h3`, `feats`, `price` (`.eur`/`.amt`/`.sub`/`.was`), `ctabtn`.
- `pay`/`payc` — tranche di pagamento (`.n`/`.pc`/`.euro`/`p`).
- `contact-row`/`ci` — contatti finali.
- `proofgrid`/`reviews`/`rev`/`cases`/`casebox` — prove (recensioni + case).
- Loghi: `stackrow` > `iconchip` > `img` (loghi servizi su chip bianco); `lfb` (fallback chip testuale); `toollogo`; `logo-nawave` (logo cliente, rinomina per nuovo cliente).

### Mockup bespoke esistenti (riferimento)
Classi prefissate per slide-mockup curati: `m9-` (Home browser con nav/hero/showreel), `m11-` (Portfolio), `m12-` (Blog), `m13-` (Form), `m14-` (Booking). Sono il livello di craft target.

---

## Sistema di animazione (già in `deck.css`)

Attivo **solo in modalità Presenta** (`.present-slide …`), rispetta `prefers-reduced-motion`. Nello scroll i contenuti sono già visibili.

- `deck-stage-in` — la slide entra con un velo (scale+blur+brightness).
- `deck-reveal` — blocchi di `.pad > *` entrano in cascata (stagger per `nth-child`, già mappato fino a 8 figli).
- `deck-title-rise` — il titolo entra con wipe `clip-path` dal basso.
- `deck-fade` + `deck-reveal` su `cards .card` / `idx li` / `feats li` — griglie a cascata.
- Divider: **word-mask rise** (`deck-word-rise`) su `chapter-num` e `chapter-title` (serve markup `<span class="word"><span>parola</span></span>`), filo verticale che cresce (`deck-rule-grow`).
- Blob: bloom d'ingresso + loop ambient (`deck-blob-rotate/morph/pulse/drift`).
- Hover-lift (in scroll **e** Presenta): `card`, `bigstep`, `payc`, `rev`, `sd-box`, `spunto`, `iconchip`, `ctabtn`, `cmp .r`, liste — lift + bordo acceso.

**Implicazione per la generazione**: per far funzionare lo stagger, metti i blocchi come **figli diretti di `.pad`** nell'ordine di comparsa voluto. Per i divider usa il markup `word`/`span`. Non serve altro: niente JS per slide.

---

## Brandfetch — solo loghi servizi

**Brandfetch serve SOLO per i loghi dei servizi/tool** (stack + tracking): Astro, Sanity, Vercel, Brevo, GA4, Google, Meta, TikTok, Cal.com, ecc.
**Il logo cliente NON si prende da Brandfetch**: lo fornisce l'utente → salvalo in `public/<slug>/`.

### Meccanismo
- **Logo Link CDN**: `https://cdn.brandfetch.io/{dominio}/w/{w}/h/{h}/theme/{light|dark}/logo.png?c={CLIENT_ID}` (es. dominio `astro.build`, `vercel.com`, `sanity.io`).
- **Search**: `https://api.brandfetch.io/v2/search/{query}?c={CLIENT_ID}` per trovare brandId/dominio.
- **Client ID** gratuito da brandfetch.com/developers.

### Regola operativa per la piattaforma
Poiché gli inline `<script>` NON girano (`dangerouslySetInnerHTML`), **non affidarti al CDN a runtime con fallback JS**. Invece:

1. In fase di generazione, **scarica** i loghi servizi via Brandfetch CDN (`curl`) e **salvali in locale** in `public/<slug>/` come `ico-<servizio>.webp/png`.
2. Nelle slide referenziali con path relativo: `<img src="/<slug>/ico-vercel.webp" alt="Vercel">` dentro `.iconchip`/`.stackrow`.
3. Se un logo non si scarica, usa il fallback testuale `lfb` **statico** nel markup (chip col nome), non uno script.

Variante per sfondo: su slide dark serve la versione chiara del logo (`theme/light` di Brandfetch dà spesso il logo bianco). Verifica il contrasto.

---

## Derivare il deck dall'MD

Mappa MD → tappe → slide:

| Tappa narrativa | Sezione MD | Slide deck (pattern) |
|---|---|---|
| Attenzione | Titolo + intro | `cover` (logo cliente) → `index` |
| Chi è BizStudio | (credibility) | divider + `chi` |
| Problema (AS-IS/TO-BE) | Situazione attuale/desiderata | divider + `sd` |
| Soluzione ⭐ | La soluzione nel dettaglio | divider + approccio + architettura + N moduli + ricorrenti + "Oltre il brief" (vedi sotto) |
| Prove | Referenze | `proofgrid`/`reviews`/`cases` |
| Come lavoriamo / Tempi | Come lavoriamo | divider + `tl` (roadmap) + collaborazione (`cards`) |
| Differenziazione | Tabella comparativa | `cmp` + slide "Perché noi" |
| Prezzo | Investimento | divider + `offercard` + `pay` |
| Next step | Prossimi passi + contatti | divider + `contact-row` / cover di chiusura |

### La Soluzione nel deck — profondità massima
Sotto-struttura ricorrente (rif. Nawave: 14 slide soluzione su 29):

| Sotto-sezione | Tipo | Box |
|---|---|---|
| **A · Strategica** — approccio in N stadi | forma fissa | `stepflow`/`bigstep`/`bigarr` |
| **B · Architettura** — mappa di tutti i moduli | forma fissa | `cards.c3` con ①②③ |
| **C · Focus moduli ×N** — mix pagine + funzionalità, NON 1 per pagina | **variabile**, stesso pattern + **mockup bespoke** | `twocol` (`spec` + `browser`/`formmock`/`popup`/`vidgrid`) + `spunto` 💡 |
| **D · Spunti** — pervasivi + slide "Oltre il vostro brief" | ricorrente | `.spunto` ovunque + slide `cards` |
| **E · Autonomia & dati** (+ tracciamenti) | standard ricorrente | `cards` |
| **F · Esperienza & motion + Stack & performance** (velocità/tech/responsive, loghi) | standard ricorrente | `stackrow` |

**Regole**:
- 1+ slide per modulo dall'MD; moduli pesanti → 2-3 slide. **Nessun tetto.**
- Ogni slide-modulo: **mockup/visual dominante + spunto 💡**. Mai slide tipografica pura.
- Tutte le slide-modulo dello stesso capitolo usano **lo stesso pattern strutturale** (coerenza); cambia il contenuto e il mockup.
- Eyebrow numerata coerente con l'MD ("1 · …", "2 · …").
- Per **altri business** (settori diversi da web/agency): replica questa profondità generando mockup bespoke adatti al deliverable (es. per un e-commerce: mockup scheda prodotto/checkout; per un centro medico: mockup pagina servizio/prenotazione).

---

## Mockup bespoke — come estendere `deck.css`

Quando un modulo merita un mockup che non c'è:
1. Scrivi il markup nella stringa HTML della slide.
2. Aggiungi le classi CSS **in fondo a `app/deck.css`**, **prefissate** per evitare collisioni: usa `<slug>-…` (es. `kruz-prod-`) o lo schema esistente `m<n>-…`.
3. Anima sfruttando il sistema esistente (i figli di `.pad` ottengono già lo stagger; per mockup interni usa transizioni hover come fanno `m9-it`).
4. Mantieni unità `cqw` (tutto scala col container), palette fissa, leggibilità.

---

## JSON: formato del file
`presentations/<slug>-slides.json` è un **array di stringhe** (ogni stringa è l'HTML completo di una slide, di norma il blocco `<div class="frame">…</div>`). Minificato o leggibile, indifferente al renderer. Aggiorna sempre `registry.ts` di conseguenza.
