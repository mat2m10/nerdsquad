# Nerd Squad: stay safe & roll initiative

Build your own board game in the browser, then play it live with friends.

Nerd Squad is a Rails app made by a five-person team during the
[Le Wagon](https://www.lewagon.com) coding bootcamp (November 2020). The team kept
working on it until December 2021. You design a game from its parts: a board,
dice, card decks, pieces and tokens. Then you open a game room where everyone
moves the same pieces in real time and chats while they play. Monopoly and chess
come ready-made in the seed data.

> **Status:** not maintained. The last change to the app was in December 2021.

## Screenshots

<!-- TODO: add 2-3 screenshots or a GIF of a live game room (dragging pieces,
     rolling dice, chat) once the app runs again. -->
_Screenshots coming soon._

## Features

- **Game builder:** create a game, then add a board, dice, card decks with cards,
  pieces and tokens, each with its own uploaded image. You can preview a game
  before playing it.
- **Clones:** playing a game makes a copy of it (a "clone" of every part), so a
  match never changes the original game.
- **Live game rooms:** drag pieces, cards and tokens on the board (mouse or touch).
  Every move is broadcast to everyone in the room through Action Cable.
- **Chat** inside each game room.
- **Search** games by name (Postgres full-text search via `pg_search`).
- **Accounts** with Devise. Everything except the home page and the sign-in and
  sign-up pages requires login.

## Stack

| | |
|---|---|
| Backend | Ruby 2.6.6, Rails 6.0, PostgreSQL, Devise, Action Cable (Redis in production) |
| Frontend | Webpacker 4, Bootstrap 4, jQuery, Turbolinks, plain JavaScript for drag and drop |
| Images | Active Storage on Cloudinary (in development too) |

These versions are end-of-life. An upgrade to a current Ruby and Rails is being
worked on separately.

## Running it locally

You need Ruby 2.6.6, Bundler, Node with Yarn, and PostgreSQL. You also need a
Cloudinary account, because development stores uploads on Cloudinary.

```bash
git clone https://github.com/mat2m10/nerdsquad.git
cd nerdsquad
bundle install
yarn install
echo "CLOUDINARY_URL=cloudinary://<api_key>:<api_secret>@<cloud_name>" > .env
bin/rails db:create db:migrate db:seed   # seeds upload the Monopoly and chess images
bin/rails server
```

Then open http://localhost:3000. The seeds create two test accounts,
`b@t.man` and `r@b.in`, both with password `123456`. Use them only locally.

In production, Action Cable needs Redis through `REDISCLOUD_URL`, and the
database comes from `DATABASE_URL`.

## Team

| | GitHub | Role |
|---|---|---|
| Raphael Marsan | [@margerabe](https://github.com/margerabe) | Main developer: most of the commits, November 2020 to December 2021 |
| Matthieu de Hemptinne | [@mat2m10](https://github.com/mat2m10) | Early contributor, November–December 2020 |
| Pierre Lion | [@JavaProScript](https://github.com/JavaProScript) | Contributor, November–December 2020 |
| Aurelie Rousseau | [@Aurrou](https://github.com/Aurrou) | Contributor, November 2020 |
| Nicolas Eloy | [@Nicoeloy](https://github.com/Nicoeloy) | Contributor, November 2020 |

Generated from the [Le Wagon Rails templates](https://github.com/lewagon/rails-templates).
