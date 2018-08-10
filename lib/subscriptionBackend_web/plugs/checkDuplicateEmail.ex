defmodule SubscriptionBackendWeb.Plugs.CheckDuplicateEmail do
  import Plug.Conn
  import Ecto.Query

  alias SubscriptionBackend.Repo
  alias SubscriptionBackend.Newsletter.Subscriber

  def init(_params) do
  end

  def call(conn, _params) do

    email = to_string(conn.params["email"])

    duplicate_emails =
    Subscriber
    |> Ecto.Query.where(email: ^email)
    |> Repo.all

    if Kernel.length(duplicate_emails) > 0 do
      conn
      |> assign(:duplicate_email?, true)

    else
      conn
      |> assign(:duplicate_email?, false)

    end
  end
end
