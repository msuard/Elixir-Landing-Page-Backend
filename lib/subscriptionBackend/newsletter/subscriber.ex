defmodule SubscriptionBackend.Newsletter.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset


  schema "subscribers" do
    field :email, :string, null: false
    field :first_name, :string, null: false
    field :last_name, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(subscriber, attrs) do
    subscriber
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
