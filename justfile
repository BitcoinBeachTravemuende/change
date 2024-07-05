#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
# https://github.com/casey/just/blob/master/justfile#L1-L3
# or
# https://just.systems/man/en/chapter_58.html#just-scripts

alias d := dev

alias b := build

alias t := test

# list available recipes
default:
  just --list

# build sources and run dev server
dev:
  npx vite

# build sources for production
build:
  npx build

# run server to preview sources for production 
preview:
  npx preview

# run elm-format
format:
  elm-format src/ --yes

# run elm-review
review:
  elm-review --fix

# run tests
test:
  elm-test "src/**/*Tests.elm"

# run and watch tests
test-w:
  elm-test "src/**/*Tests.elm" --watch
