defmodule SubscriptionBackendWeb.Plugs.ValidateDomain do
  import Plug.Conn
  alias SubscriptionBackend.Utils


  def init(_params) do
  end

  def call(conn, _params) do

    email = to_string(conn.params["email"])

    case Utils.validate_domain(email) do

      {:error, "Invalid domain"} ->
        conn
        |> assign(:is_valid_domain?, false)

      {:ok, "Valid domain"} ->
        conn
        |> assign(:is_valid_domain?, true)

    end

  end
end
