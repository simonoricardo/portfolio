set positional-arguments

[private]
default:
  just --list

@build:
  mix site.build

@dev:
  cd output && npx hostr -p 8000

@start: build dev

@deploy: build
  fly deploy
