# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Cos'è

Sito statico Jekyll pubblicato su GitHub Pages (https://redolfi-unibs.github.io) per i corsi universitari PAJC (Programmazione Avanzata Java e C) ed EPS (Elementi di Progettazione Software, dismesso nel 2022). Contenuti e commit sono in italiano.

## Build e deploy

Non c'è `Gemfile`, toolchain locale né test: il sito viene costruito da GitHub Pages al push su `master` (branch di default, non `main`). Il tema è `jekyll-theme-architect` dichiarato in `_config.yml`, ma i layout e i CSS sono tutti locali e lo sovrascrivono di fatto.

Per un'anteprima locale (opzionale, richiede Ruby/Jekyll installati):

```bash
jekyll serve
```

Attenzione: `url` in `_config.yml` è assoluto e tutti i link interni usano `{{ site.url }}`, quindi in locale i link puntano comunque al sito pubblicato.

## Struttura

- `index.html` — home; il banner in cima mostra `site.news` da `_config.yml` (unica "news" del sito: si aggiorna lì).
- `docs/*.md` — le quattro pagine di contenuto, con `layout: docs` e `permalink` esplicito: `pajc.md`, `eps.md`, `altro.md` (esiti appelli), `modalita_esame.md`.
- `assets/esiti_pajc/`, `assets/esiti_eps/` — PDF degli esiti, nominati `PAJC-esiti-YYYY-MM-DD.pdf`.
- `_layouts/` e `_includes/` — template ereditati da un vecchio sito (OWNER); molti include sono commentati o inutilizzati (`news*`, `features.html`). La sidebar delle pagine docs è `_includes/docs_contents.html`.

## Operazione ricorrente: pubblicare gli esiti di un appello

È l'attività quasi esclusiva del repo (vedi `git log`). Passi:

1. Copiare il PDF in `assets/esiti_pajc/PAJC-esiti-YYYY-MM-DD.pdf`.
2. In `docs/altro.md` aggiungere in cima alla lista (ordine cronologico decrescente) una riga:
   `[PAJC - appello GG mese AAAA]({{ site.url }}/assets/esiti_pajc/PAJC-esiti-YYYY-MM-DD.pdf)`
3. Messaggio di commit nello stile `appello YYYY-MM-DD`.

## Note

- I link al materiale del corso (Dropbox, Google Meet) sono reference link in testa a `docs/pajc.md`; a ogni anno accademico si aggiornano lì insieme al testo che cita l'anno.
- La sidebar evidenzia la voce corrente confrontando `page.title` con stringhe fisse ("PAJC", "EPS", "Altro"): la pagina esiti ha titolo "Esiti appelli", quindi non risulta mai evidenziata. Se si rinomina un titolo, aggiornare anche `docs_contents.html`.
