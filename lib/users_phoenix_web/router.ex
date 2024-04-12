defmodule UsersPhoenixWeb.Router do
  use UsersPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug UsersPhoenix.Users.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", UsersPhoenixWeb do
    pipe_through [:api, :auth]

    post "/users", UserController, :create
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  scope "/api", UsersPhoenixWeb do
    pipe_through [:api, :auth, :ensure_auth]

    resources "/users", UserController, except: [:new, :edit]
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:users_phoenix, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: UsersPhoenixWeb.Telemetry
    end
  end
end
