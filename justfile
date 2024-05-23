set positional-arguments

[private]
default:
  just --list

@build:
  mix site.build

@dev:
  cd output && npx hostr -p 8000

@deploy: build
  fly deploy
