defmodule SubscriptionBackendWeb.SubscriberController do
  use SubscriptionBackendWeb, :controller

  alias SubscriptionBackend.Newsletter
  alias SubscriptionBackend.Newsletter.Subscriber

  action_fallback SubscriptionBackendWeb.FallbackController

  def index(conn, _params) do
    subscribers = Newsletter.list_subscribers()
    render(conn, "index.json", subscribers: subscribers)
  end

  def create(conn, %{"subscriber" => subscriber_params}) do
    with {:ok, %Subscriber{} = subscriber} <- Newsletter.create_subscriber(subscriber_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", subscriber_path(conn, :show, subscriber))
      |> render("show.json", subscriber: subscriber)
    end
  end

  def show(conn, %{"id" => id}) do
    subscriber = Newsletter.get_subscriber!(id)
    render(conn, "show.json", subscriber: subscriber)
  end

  def update(conn, %{"id" => id, "subscriber" => subscriber_params}) do
    subscriber = Newsletter.get_subscriber!(id)

    with {:ok, %Subscriber{} = subscriber} <- Newsletter.update_subscriber(subscriber, subscriber_params) do
      render(conn, "show.json", subscriber: subscriber)
    end
  end

  def delete(conn, %{"id" => id}) do
    subscriber = Newsletter.get_subscriber!(id)
    with {:ok, %Subscriber{}} <- Newsletter.delete_subscriber(subscriber) do
      send_resp(conn, :no_content, "")
    end
  end
end
