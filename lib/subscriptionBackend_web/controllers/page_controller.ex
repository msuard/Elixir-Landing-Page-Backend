defmodule SubscriptionBackendWeb.PageController do
  use SubscriptionBackendWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
