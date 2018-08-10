defmodule SubscriptionBackendWeb.HealthControllerTest do
  use SubscriptionBackendWeb.ConnCase

  test "GET /subscribe/health", %{conn: conn} do
    conn = get conn, "/subscribe/health"
    response = json_response(conn, 200)
    case response do
      %{"timestamp" => timestamp} -> assert is_binary(timestamp)
      _ ->
        assert 0 = 1
    end
  end
end
