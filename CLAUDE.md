# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Cos'è

Sito statico Jekyll pubblicato su GitHub Pages (https://redolfi-unibs.github.io) per i corsi universitari PAJC (Programmazione Avanzata Java e C) ed EPS (Elementi di Progettazione Software, dismesso nel 2022). Contenuti e commit sono in italiano.

## Build e deploy

Non ci sono test: il sito viene costruito da GitHub Pages al push su `master` (branch di default, non `main`). Il tema è `jekyll-theme-architect` dichiarato in `_config.yml`, ma i layout e i CSS sono tutti locali e lo sovrascrivono di fatto.

### Anteprima locale

Il `Gemfile` porta la gemma `github-pages` (Jekyll 3.10, la stessa toolchain di GitHub Pages, che il Gemfile lo ignora). Due modi equivalenti:

- **Docker + Traefik condiviso** (`docker-utils`), come gli altri progetti: `docker compose up -d` e poi <https://redolfi-unibs.localhost>. Nessuna porta pubblicata sull'host; con `SLUG` nel `.env` si isolano stack paralleli. L'hostname è registrato nel cert di docker-utils. Niente livereload (lo snippet sarebbe mixed content dietro https): si ricarica a mano, la rigenerazione è a polling entro un paio di secondi.
- **Nativo** (Ruby via rbenv): `bundle install` una volta, poi `bundle exec jekyll serve` e <http://localhost:4000>. In sviluppo `jekyll serve` sovrascrive da solo `site.url` con localhost, quindi i link assoluti `{{ site.url }}` funzionano anche in locale.

Nel container `docker/serve.sh` avvia Jekyll con `JEKYLL_ENV=production` più un config generato al volo con `url: https://<host>`, perché solo in `development` scatta l'override dell'URL. Nessun template dipende dall'ambiente.

`_config.yml` esclude dal sito pubblicato `vendor`, `Gemfile*`, `docker*`, `CLAUDE.md` e `README.md`: non rimuovere quelle voci, altrimenti vengono serviti come file statici.

## Struttura

- `index.html` — home; il banner in cima mostra `site.news` da `_config.yml` (unica "news" del sito: si aggiorna lì).
- `docs/*.md` — le quattro pagine di contenuto, con `layout: docs` e `permalink` esplicito: `pajc.md`, `eps.md`, `esiti.md` (esiti appelli, con `redirect_from` dal vecchio `/docs/altro/`), `modalita_esame.md`.
- `assets/esiti_pajc/` — PDF degli esiti pubblicati (dal 2026), nominati `PAJC-esiti-YYYY-MM-DD.pdf`.
- `archivio/` — esiti PAJC ed EPS fino al 2025: nel repo ma escluso dalla build, non raggiungibile dal sito.
- `_layouts/` e `_includes/` — template ereditati da un vecchio sito (OWNER); molti include sono commentati o inutilizzati (`news*`, `features.html`). La sidebar delle pagine docs è `_includes/docs_contents.html`.

## Operazione ricorrente: pubblicare gli esiti di un appello

È l'attività quasi esclusiva del repo (vedi `git log`). Passi:

1. Copiare il PDF in `assets/esiti_pajc/PAJC-esiti-YYYY-MM-DD.pdf`.
2. In `docs/esiti.md` aggiungere in cima alla lista (ordine cronologico decrescente) una riga:
   `[PAJC - appello GG mese AAAA]({{ site.url }}/assets/esiti_pajc/PAJC-esiti-YYYY-MM-DD.pdf)`
3. Messaggio di commit nello stile `appello YYYY-MM-DD`.

## Note

- I link al materiale del corso (Dropbox, Google Meet) sono reference link in testa a `docs/pajc.md`; a ogni anno accademico si aggiornano lì insieme al testo che cita l'anno.
- La sidebar evidenzia la voce corrente confrontando `page.title` con stringhe fisse ("PAJC", "EPS", "Esiti appelli") in `docs_contents.html`: se si rinomina un titolo, aggiornare anche lì.
