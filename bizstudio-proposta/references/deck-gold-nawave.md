# Deck gold — Nawave (riferimento canonico)

Il deck Nawave è il **gold standard** del deck BizStudio sulla piattaforma. Quando devi sapere la resa esatta di una scheda, apri questi file reali:

- Contenuto: `presentazioni-bizstudio/presentations/nawave-slides.json` (array di 29 stringhe HTML)
- Stile + animazioni: `presentazioni-bizstudio/app/deck.css` (~1130 righe)
- Renderer: `presentazioni-bizstudio/components/Deck.tsx`
- Registrazione: `presentazioni-bizstudio/presentations/registry.ts`
- MD sorgente: `references/proposte-vinte/nawave.md`

Settore: agency TikTok / sito vetrina + lead system. Prezzo €2.500 → €2.000. Stack Astro/Vercel/Sanity/Brevo + tracking GA4/Meta/TikTok + Cal.com.

---

## Mappa delle 29 slide

```
 1  cover            [Proposta · Sito vetrina] "Il sito che trasforma l'attenzione in clienti"
 2  index            table of contents
 3  divider 01       Chi è BizStudio
 4  chi              credibility: logo + body + reviews.png + portfolio.png
 5  divider 02       Il problema
 6  sd               AS-IS ⚠️ / TO-BE 🎯 (4 sd-box per lato)
 7  divider 03       La soluzione
 8  bg-light         [L'approccio] "Non un sito: un funnel orizzontale"   (stepflow A·strategica)
 9  bg-dark 💡       [Architettura del sito] "Sette pagine, un solo racconto"   (cards.c3 B·mappa)
10  bg-dark 💡       [1 · La Home] "La prima schermata che converte"   (twocol spec + m9- browser mockup)
11  bg-dark 💡       [2 · Le pagine che vi raccontano] metodo/team/TikTok Shop
12  bg-dark 💡       [3 · Portfolio] "I lavori che parlano per voi"   (m11-)
13  bg-dark 💡       [4 · Blog] "Da video virale ad articolo che ranka"   (twocol + browser, m12-)
14  bg-dark 💡       [5 · Form guidato] "Un form che fa le domande giuste"   (formmock, m13-)
15  bg-dark 💡       [6 · Booking & freebie] "Due porte in più, per ogni temperatura"   (popup, m14-)
16  bg-dark          [7 · Automazioni & gestione lead] "Ogni lead arriva dove serve, da solo"   (flow/fbox)
17  bg-dark 💡       [Autonomia & dati] "Aggiornate tutto da soli. E misurate ogni click."   (E·ricorrente, cards)
18  bg-dark 💡       [Esperienza & motion] "Fluido come i siti premium, perfetto su mobile"   (F·ricorrente)
19  bg-dark 💡       [Stack & performance] "Costruito per caricare in meno di un secondo"   (stackrow loghi servizi)
20  bg-light         [Oltre il vostro brief] "Voi ci chiedete un sito. Noi ci montiamo la macchina dei lead"   (D·proiezione valore)
21  divider 04       Come lavoriamo
22  bg-light         [Il percorso, fase per fase] "Dal sì al sito online in 10 giorni"   (tl/tlp roadmap)
23  bg-dark          [Come restiamo in contatto] "Sempre in linea, mai persi"   (collaborazione, cards)
24  bg-dark          [Perché noi] "Nawave con BizStudio vs il resto"   (cmp comparativa)
25  divider 05       L'investimento
26  bg-dark          pricing   (offercard: feats + price €2.500→€2.000 + ctabtn)
27  bg-dark          [Come si paga] "In tre rate, sugli stadi del lavoro"   (pay/payc)
28  divider 06       Contatti finali
29  cover            [Parliamone] "Confermate e partiamo con la raccolta materiali"   (chiusura + logo)
```

## Cosa imparare da qui

- **Capitoli numerati** (01-06) come spina dorsale, ognuno aperto da un `divider` bg-grad. Ma l'architettura resta una **libreria flessibile**: per altri business cambia numero/ordine dei capitoli.
- **Soluzione = 14 slide su 29** (slide 7-20): è il capitolo più lungo. A·approccio → B·architettura → C·7 moduli numerati (ognuno con mockup bespoke + 💡) → E/F·ricorrenti (autonomia/dati, esperienza/motion, stack) → D·"Oltre il brief".
- **Spunto 💡 pervasivo** sui moduli soluzione: è la firma consulenziale.
- **Mockup bespoke** `m9-`/`m11-`/`m12-`/`m13-`/`m14-`: livello di craft target per i moduli pesanti (browser, form, popup).
- **Loghi servizi** in `stackrow`/`iconchip` (slide 19); **logo cliente** in cover (1) e chiusura (29).
- **Prezzo** (26) bianco pieno, peso massimo; **rate** (27) separate.
- Tutto il sistema di **animazione a comparsa** è in `deck.css`, attivo solo in modalità Presenta.
