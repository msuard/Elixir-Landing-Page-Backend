defmodule SubscriptionBackendWeb.SubscriberController do
  use SubscriptionBackendWeb, :controller

  alias SubscriptionBackend.Newsletter.Subscriber
  alias SubscriptionBackend.Newsletter
  alias SubscriptionBackend.Utils

  def create(conn, %{"first_name" => first_name, "last_name" => last_name, "email" => email}) do

    params = %{first_name: first_name, last_name: last_name, email: email}

    case Newsletter.create_subscriber(params) do
      {:ok, %Subscriber{}} ->
        conn
        |> put_status(:created)
        |> json(%{ status: "Success", params: params})

      {:error, changeset} ->
        error = Utils.handle_changeset_errors(changeset.errors)
        conn
        |> put_status(:bad_request)
        |> json(%{ status: error, params: params})

      _ ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{ status: "Error: something went wrong...", params: params})
    end

  end

end
