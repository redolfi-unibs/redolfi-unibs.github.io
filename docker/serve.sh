#!/bin/sh
# Avvia jekyll serve dietro Traefik.
#
# In JEKYLL_ENV=development `jekyll serve` forza site.url a http://<host>:4000,
# che dietro il proxy non è raggiungibile. Con JEKYLL_ENV=production l'override
# non scatta e vale l'url del config aggiuntivo generato qui dall'hostname Traefik.
# In production jekyll-github-metadata imposta anche baseurl se manca, e per
# farlo interroga il repository (git remote / API): dichiarandolo vuoto lo evita.
# Nulla d'altro nei template dipende dall'ambiente.
#
# --force_polling: il bind mount su macOS non propaga gli eventi inotify.
# Niente --livereload: lo snippet punterebbe a http://<host>:35729, bloccato
# come mixed content dalla pagina https. Si ricarica a mano.
set -eu

: "${SITE_HOST:?SITE_HOST non impostata}"

printf 'url: https://%s\nbaseurl: ""\n' "$SITE_HOST" > /tmp/_config_docker.yml

export JEKYLL_ENV=production
exec bundle exec jekyll serve \
  --host 0.0.0.0 --port 4000 \
  --config _config.yml,/tmp/_config_docker.yml \
  --destination /tmp/_site \
  --force_polling
