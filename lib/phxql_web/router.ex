defmodule PhxQLWeb.Router do
  use PhxQLWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {PhxQLWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(PhxQLWeb.Plugs.SetCurrentUser)
  end

  pipeline :authenticated do
    # This is only works if you use Guardian for Authentication.
    # So don't apply it on any routes unless you already used Guardian
    # to authenticate users to your resources.
    plug(PhxQLWeb.Auth.Pipeline)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(PhxQLWeb.Plugs.Context)
  end

  scope "/", PhxQLWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    delete("/logout", SessionController, :delete)

    resources("/register", RegisterController, only: [:new, :create])
    resources("/users", UserController, only: [:index, :show])
  end

  # Here is my GraphQL APIs that is protected through Absinthe Implementation.
  scope "/api" do
    pipe_through(:api)
    forward("/graphql", Absinthe.Plug, schema: PhxQLWeb.Schema)

    if Mix.env() == :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL, schema: PhxQLWeb.Schema)
    end
  end

  # Here I put my REST APIs under protection.
  # scope "/api" do
  #   pipe_through([:api, :authenticated])
  #   resources("/users", UserController, only: [:index, :show])
  # end

  # Other scopes may use custom stacks.
  # scope "/api", PhxQLWeb do
  #   pipe_through :api
  # end
end
