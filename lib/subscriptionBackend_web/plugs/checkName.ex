defmodule SubscriptionBackendWeb.Plugs.CheckName do
  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do

    first_name = to_string(conn.params["first_name"])
    last_name = to_string(conn.params["last_name"])

    full_name_is_string? = is_binary(first_name<>" "<>last_name) #IS IS CORRECT TO CHECK FOR BINARY?


    if full_name_is_string? do
      conn
      |> assign(:full_name_is_string?, true)

    else
      conn
      |> assign(:full_name_is_string?, false)

    end

  end
end
