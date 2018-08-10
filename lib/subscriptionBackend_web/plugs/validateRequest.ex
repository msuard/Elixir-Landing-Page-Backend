defmodule SubscriptionBackendWeb.Plugs.ValidateRequest do
  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do

    checks = %{
      is_valid_email?: conn.assigns.is_valid_email?,
      is_valid_domain?: conn.assigns.is_valid_domain?,
      duplicate_email?: conn.assigns.duplicate_email?,
      full_name_is_string?: conn.assigns.full_name_is_string?,
    }

    case checks do
      %{is_valid_email?: true, is_valid_domain?: true, duplicate_email?: false, full_name_is_string?: true} ->
        conn
        |> assign(:valid_request?, true)
        |> assign(:status, "Success: new subscriber inserted")

      %{is_valid_email?: false, is_valid_domain?: a, duplicate_email?: b, full_name_is_string?: c} ->
        conn
        |> assign(:valid_request?, false)
        |> assign(:status, "Error: invalid email")

      %{is_valid_email?: true, is_valid_domain?: false, duplicate_email?: a, full_name_is_string?: b} ->
        conn
        |> assign(:valid_request?, false)
        |> assign(:status, "Error: invalid domain")

      %{is_valid_email?: true, is_valid_domain?: true, duplicate_email?: true, full_name_is_string?: a} ->
        conn
        |> assign(:valid_request?, false)
        |> assign(:status, "Error: duplicate email")

      %{is_valid_email?: true, is_valid_domain?: true, duplicate_email?: false, full_name_is_string?: false} ->
        conn
        |> assign(:valid_request?, false)
        |> assign(:status, "Error: full name must be a string")

      _  ->
        conn
        |> assign(:valid_request?, false)
        |> assign(:status, "Error: something went wrong...")

    end

  end
end
