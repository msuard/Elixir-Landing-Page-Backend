defmodule SubscriptionBackend.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:subscribers, [:email])

  end
end
