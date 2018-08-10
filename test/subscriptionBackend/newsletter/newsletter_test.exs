defmodule SubscriptionBackend.NewsletterTest do
  use SubscriptionBackend.DataCase

  alias SubscriptionBackend.Newsletter

  describe "subscribers" do
    alias SubscriptionBackend.Newsletter.Subscriber

    @valid_attrs %{email: "some.email@valid.domain.xyz", first_name: "some first_name", last_name: "some last_name"}
    @missing_attrs %{email: nil, first_name: nil, last_name: nil}
    @invalid_email %{email: "invalid email", first_name: "some first_name", last_name: "some last_name"}
    @invalid_first_name %{email: "some.email@valid.domain.xyz", first_name: 123456, last_name: "some last_name"}
    @invalid_last_name %{email: "some.email@valid.domain.xyz", first_name: "some first_name", last_name: 123456}
    @invalid_domain %{email: "some.email@duck2.xyz", first_name: "some first_name", last_name: "some last_name"}



    def subscriber_fixture(attrs \\ %{}) do
      {:ok, subscriber} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Newsletter.create_subscriber()

      subscriber
    end

    test "create_subscriber/1 with valid data creates a subscriber" do
      assert {:ok, %Subscriber{} = subscriber} = Newsletter.create_subscriber(@valid_attrs)
      assert subscriber.email == "some.email@valid.domain.xyz"
      assert subscriber.first_name == "some first_name"
      assert subscriber.last_name == "some last_name"
    end

    test "create_subscriber/1 with missing attributes returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Newsletter.create_subscriber(@missing_attrs)
    end

    test "create_subscriber/1 with invalid email returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Newsletter.create_subscriber(@invalid_email)
      assert changeset.errors[:email] == {"Invalid email format", [validation: :format]}
    end

    test "create_subscriber/1 with invalid first name returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Newsletter.create_subscriber(@invalid_first_name)
      assert changeset.errors[:first_name] == {"is invalid", [type: :string, validation: :cast]}
    end

    test "create_subscriber/1 with invalid last name returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Newsletter.create_subscriber(@invalid_last_name)
      assert changeset.errors[:last_name] == {"is invalid", [type: :string, validation: :cast]}
    end

    test "create_subscriber/1 with invalid domain returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Newsletter.create_subscriber(@invalid_domain)
      assert changeset.errors[:email] == {"Invalid email domain", []}
    end

    test "create_subscriber/1 with already registered email returns error changeset" do
      assert {:ok, %Subscriber{} = subscriber} = Newsletter.create_subscriber(@valid_attrs)
      assert {:error, %Ecto.Changeset{} = changeset} = Newsletter.create_subscriber(@valid_attrs)
      assert changeset.errors[:email] == {"Email already registered in database", []}
    end

  end
end
