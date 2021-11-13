defmodule PhxQLWeb.Router do
  use PhxQLWeb, :router

  import PhxQLWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {PhxQLWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug :fetch_current_user
  end

  # pipeline :authenticated do
  #   # This is only works if you use Guardian for Authentication.
  #   # So don't apply it on any routes unless you already used Guardian
  #   # to authenticate users to your resources.
  #   plug(PhxQLWeb.Auth.Pipeline)
  # end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(PhxQLWeb.Plugs.Context)
  end

  scope "/", PhxQLWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
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

  ## Authentication routes

  scope "/", PhxQLWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", PhxQLWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", PhxQLWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
