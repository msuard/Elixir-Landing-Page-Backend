defmodule SubscriptionBackendWeb.Plugs.ValidateEmail do
  import Plug.Conn
  alias SubscriptionBackend.Utils


  def init(_params) do
  end

  def call(conn, _params) do

    email = to_string(conn.params["email"])

     case Utils.validate_email(email) do

      {:error, "Invalid email"} ->
        conn
        |> assign(:is_valid_email?, false)

       {:ok, "Valid email"} ->
        conn
        |> assign(:is_valid_email?, true)

    end

  end
end
