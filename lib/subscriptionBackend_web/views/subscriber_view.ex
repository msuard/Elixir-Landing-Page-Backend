defmodule SubscriptionBackendWeb.SubscriberView do
  use SubscriptionBackendWeb, :view
  alias SubscriptionBackendWeb.SubscriberView

  def render("index.json", %{subscribers: subscribers}) do
    %{data: render_many(subscribers, SubscriberView, "subscriber.json")}
  end

  def render("show.json", %{subscriber: subscriber}) do
    %{data: render_one(subscriber, SubscriberView, "subscriber.json")}
  end

  def render("subscriber.json", %{subscriber: subscriber}) do
    %{id: subscriber.id,
      first_name: subscriber.first_name,
      last_name: subscriber.last_name,
      email: subscriber.email}
  end
end
