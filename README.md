# PhxQL
This is startup template that I found myself use so often and it take sometime to setup so I preconfigured it to be ready to work with.

# How it was configurated?
  * First I removed `milligram` CSS Framework that is used by default in __Phoenix__ by just deleting `phoenix.css` file from `/assets/css/` folder.
  * Added [`Bulma`](https://bulma.io) CSS Framework using `yarn add bulma --dev` and changed `/assets/app.css` -> `/assets/app.scss` and added to it:
    - `@import "~bulma/bulma"` to add support for __Bulma__, you can write the full path `../node_modules/bulma/bulma` if you faced issues in recognizing it.
    - `@import "./custom"` for my custom styles, refers to `/assets/_custom.scss` file.
## Webpack Configurations `webpack.config.js`
  * Support __Sass__ using [`DartSass`](https://github.com/sass/dart-sass) and [`sass-loader`](https://github.com/webpack-contrib/sass-loader).
  * Configure `sass-loader` _options:_ `{implementation: require("sass")}` so it will use `sass` instead of the default one `node-sass` and will stop complaining.
  * Added [`Elm`](https://elm-lang.org/) which was installed globally on my system, but you can install it using `yarn` or `npm` to your dependencies
  * Support __Elm__ using [`elm-webpack-loader`](https://github.com/elm-community/elm-webpack-loader)
  * While you are in `/assets` folder path, run in terminal `elm init` to initialize _elm app_ which will add `elm.json` and `src` folder for you under `/assets` folder directly.
  * In `/assets/js/app.js` file you need to write these lines of code: 
    ```js
    import { Elm } from "../src/Main.elm"
    var app = Elm.Main.init({
    node: document.getElementById('elm-main')
    });
    ```
  * I replaced everything in `/lib/YOUR_APP_WEB/templates/page/index.html.eex` file with `<div id="elm-main"></div>` as here my elm output will show up.
  * I removed most of boilerplate code that comes in `app.html.eex` file. I added also [`FontAwesome 5.9.0`](https://use.fontawesome.com/releases/v5.9.0/css/all.css)
  * Sometimes I face issues when installing `elm-webpack-loader` due to __node__ version, as I always have latest version of it so I added `.nvmrc` file inside `/assets` folder and in it I wrote [`10.16.0`](https://nodejs.org/en/) which is latest LTS version of __node__ at the time of writing this, if you want to configure `nvm` or install it on your system check [this](https://github.com/lukechilds/zsh-nvm) if you use `oh-my-zsh` or [this](https://github.com/nvm-sh/nvm) for `nvm` itself as a __Node Version Manager__
  
## Adding GraphQL
  * Add `GraphQL` for __Phoenix__ is very straight forward, check please [`Absinthe`](https://github.com/absinthe-graphql/absinthe) for installation.
  * To make __Elm__ talks `GraphQL`, we will install [`elm-graphql`](https://github.com/dillonkearns/elm-graphql) package using `elm install` command in _Terminal_ while you are in `/assets` folder as your _elm app_ installed there or if you separate it somewhere else then you need to install that package where your _elm app_ exsits.

## Phoenix Configs
  * Modified `router.ex` file with the `/graphql` and `/graphiql` routes.
  * Added some dummy folders and files for schema file, schema types, resolvers files.

## TODO
  - [x] Add folders and files for schema and resolvers.
  - [x] Add User __Authentication__ and __Authorization__.
  - [x] Add Session support.
  - [ ] Add GraphQL Schema and Resolvers.
  - [ ] Implement Elm-GraphQL and connect to our backend.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
