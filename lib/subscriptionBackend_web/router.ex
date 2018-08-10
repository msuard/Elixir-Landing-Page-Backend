defmodule SubscriptionBackendWeb.Router do
  use SubscriptionBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/subscribe", SubscriptionBackendWeb do
    pipe_through :api # Use the default api stack

    resources "/new", SubscriberController, only: [:create]

    get "/health", HealthController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SubscriptionBackendWeb do
  #   pipe_through :api
  # end
end
