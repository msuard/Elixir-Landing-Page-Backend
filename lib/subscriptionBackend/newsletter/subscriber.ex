defmodule SubscriptionBackend.Newsletter.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset
  alias SubscriptionBackend.DomainsBlackList

  schema "subscribers" do
    field :email, :string, null: false, unique: true
    field :first_name, :string, null: false
    field :last_name, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(subscriber, attrs) do
    subscriber
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email], message: "Missing field") # Ensure all parameters are passed
    |> validate_is_string(:email, message: "email should be a string")
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, message: "Invalid email format") # Ensure email is valid email
    |> validate_domain(:email, message: "Invalid email domain")
    |> unique_constraint(:email, message: "Email already registered in database") # Ensure there are no email duplicates in database
    |> validate_is_string(:first_name, message: "first_name should be a string")
    |> validate_is_string(:last_name, message: "last_name should be a string")


  end

  def validate_is_string(changeset, field, options \\ []) do
    validate_change(changeset, field, fn field, name  ->
      case is_binary(name) do       #IS IS CORRECT TO CHECK FOR BINARY?
        true -> []
        false -> [{field, options[:message]}]
      end
    end)
  end


  def validate_domain(changeset, field, options \\ []) do
    validate_change(changeset, field, fn field, email  ->
      domain =
        String.split(email, "@")
        |> Enum.at(-1)
        |> String.split(".")
        |> Enum.drop(-1)
        |> Enum.join(".")

      case domain in DomainsBlackList.domainsBlackList do
        true -> [{field, options[:message]}]
        false -> []
      end
    end)
  end

end
