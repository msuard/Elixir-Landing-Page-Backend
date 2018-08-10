defmodule SubscriptionBackendWeb.SubscriberController do
  use SubscriptionBackendWeb, :controller

  plug SubscriptionBackendWeb.Plugs.ValidateEmail
  plug SubscriptionBackendWeb.Plugs.ValidateDomain
  plug SubscriptionBackendWeb.Plugs.CheckDuplicateEmail
  plug SubscriptionBackendWeb.Plugs.CheckName
  plug SubscriptionBackendWeb.Plugs.ValidateRequest

  alias SubscriptionBackend.Newsletter.Subscriber
  alias SubscriptionBackend.Newsletter

  def create(conn, %{"first_name" => first_name, "last_name" => last_name, "email" => email}) do

    params = %{first_name: first_name, last_name: last_name, email: email}

    valid_request? = conn.assigns.valid_request?
    status = conn.assigns.status

    case valid_request?  do
      true ->
        with {:ok, %Subscriber{}} <- Newsletter.create_subscriber(params) do
          conn
          |> put_status(200)
          |> json(%{ status: status, params: params})
        end

      false ->
        conn
        |> put_status(400)
        |> json(%{ status: status, params: params})

    end

  end

end

