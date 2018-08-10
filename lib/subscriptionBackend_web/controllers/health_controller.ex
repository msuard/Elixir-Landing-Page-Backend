defmodule SubscriptionBackendWeb.HealthController do
  use SubscriptionBackendWeb, :controller

  def index(conn, _params) do

    timestamp = DateTime.utc_now()

    conn
    |> put_status(200)
    |> json(%{ timestamp: timestamp})

  end

end

