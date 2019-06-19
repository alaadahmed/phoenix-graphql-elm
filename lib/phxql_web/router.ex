defmodule PhxQLWeb.Router do
  use PhxQLWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", PhxQLWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api" do
    pipe_through(:api)
    forward("/graphql", Absinthe.Plug, schema: PhxQLWeb.Schema)

    if Mix.env() == :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL, schema: PhxQLWeb.Schema)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxQLWeb do
  #   pipe_through :api
  # end
end
