# docker-notes-site

A static documentation site containing my personal Docker learning notes —
Chapters 1–7, covering architecture, images, Dockerfiles, volumes, networking,
and Compose. Built and deployed as a Docker project in its own right.

**Live site:** _add your GitHub Pages URL here after deploying_

---

## Why this exists

While working through Docker from first principles, I kept notes chapter by
chapter — including the actual bugs I hit along the way (a volume path typo,
a stale image cache, a `depends_on` race condition) and how I diagnosed each
one. This site is those notes, cleaned up and made referenceable.

It's also, deliberately, a small real Docker project: a Dockerfile, an Nginx
base image, and a Compose file for local development — the same tools the
notes themselves are about.

## Stack

- Static HTML/CSS, no build step, no JS framework
- Served by `nginx:alpine` inside a container
- `docker-compose.yml` for one-command local runs

## Running locally

```bash
git clone <this-repo>
cd docker-notes-site
docker compose up --build
```

Visit **http://localhost:8080**.

Or without Compose:

```bash
docker build -t docker-notes-site .
docker run -d -p 8080:80 docker-notes-site
```

## Project structure

```
docker-notes-site/
├── Dockerfile              # nginx:alpine, copies site/ to the default web root
├── docker-compose.yml      # single-service local dev setup
├── .dockerignore
└── site/
    ├── index.html          # chapter index / homepage
    ├── style.css
    ├── chapter1.html … chapter7.html
    └── cheatsheet.html
```

## Deploying for free — GitHub Pages

GitHub Pages serves static files directly from a repo, at no cost:

1. Push this repo to GitHub.
2. Repo **Settings → Pages**.
3. Under **Source**, choose the branch (e.g. `main`) and set the folder to `/site`.
4. Save — GitHub publishes to `https://<username>.github.io/<repo-name>/`.

No server to maintain, no cost, updates automatically on every push to that
branch. The Docker setup above is for local development and as a portfolio
artifact — Pages hosting doesn't run the container itself, it just serves the
same static files directly.

## Notes on the Dockerfile

`nginx:alpine`'s own maintainers already bake in a `CMD` that starts Nginx
(`nginx -g "daemon off;"`). This Dockerfile never overrides it — since we only
want standard Nginx behavior, the inherited `CMD` from the base image is
exactly right. The only thing this Dockerfile adds is copying `site/` to
Nginx's hardcoded default web root, `/usr/share/nginx/html`.
