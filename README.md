# change (WIP)

_...work in progress ..._

> Built with [Elm Land](https://elm.land) 🌈

## Local development

### Requirements:

#### Nix users: 
```bash
cd {project-root}
nix develop
```

#### Others

Install the following: 

 - [Node v20+](https://nodejs.org/)
 - [Elm 19.1](https://elm-lang.org/)
 - [elm-format](https://github.com/avh4/elm-format)
 - [elm-test](https://github.com/rtfeldman/node-test-runner)
 - [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) 
 - [just](https://just.systems)

Install `Node` deps (only once)

```bash
 npm i
```

### Run scripts

List all scrips:

```bash
just --list
Available recipes:
    build   # build sources
    b       # alias for `build`
    default # list available recipes
    dev     # build sources and run dev server
    d       # alias for `dev`
    format  # run elm-format
    review  # run elm-review
    test    # run tests
    t       # alias for `test`
    test-w  # run and watch tests
```

## License

[MIT](./LICENSE)
