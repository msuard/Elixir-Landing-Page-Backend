defmodule SubscriptionBackend.NewsletterTest do
  use SubscriptionBackend.DataCase

  alias SubscriptionBackend.Newsletter

  describe "subscribers" do
    alias SubscriptionBackend.Newsletter.Subscriber

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil}

    def subscriber_fixture(attrs \\ %{}) do
      {:ok, subscriber} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Newsletter.create_subscriber()

      subscriber
    end

    test "list_subscribers/0 returns all subscribers" do
      subscriber = subscriber_fixture()
      assert Newsletter.list_subscribers() == [subscriber]
    end

    test "get_subscriber!/1 returns the subscriber with given id" do
      subscriber = subscriber_fixture()
      assert Newsletter.get_subscriber!(subscriber.id) == subscriber
    end

    test "create_subscriber/1 with valid data creates a subscriber" do
      assert {:ok, %Subscriber{} = subscriber} = Newsletter.create_subscriber(@valid_attrs)
      assert subscriber.email == "some email"
      assert subscriber.first_name == "some first_name"
      assert subscriber.last_name == "some last_name"
    end

    test "create_subscriber/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Newsletter.create_subscriber(@invalid_attrs)
    end

    test "update_subscriber/2 with valid data updates the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, subscriber} = Newsletter.update_subscriber(subscriber, @update_attrs)
      assert %Subscriber{} = subscriber
      assert subscriber.email == "some updated email"
      assert subscriber.first_name == "some updated first_name"
      assert subscriber.last_name == "some updated last_name"
    end

    test "update_subscriber/2 with invalid data returns error changeset" do
      subscriber = subscriber_fixture()
      assert {:error, %Ecto.Changeset{}} = Newsletter.update_subscriber(subscriber, @invalid_attrs)
      assert subscriber == Newsletter.get_subscriber!(subscriber.id)
    end

    test "delete_subscriber/1 deletes the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, %Subscriber{}} = Newsletter.delete_subscriber(subscriber)
      assert_raise Ecto.NoResultsError, fn -> Newsletter.get_subscriber!(subscriber.id) end
    end

    test "change_subscriber/1 returns a subscriber changeset" do
      subscriber = subscriber_fixture()
      assert %Ecto.Changeset{} = Newsletter.change_subscriber(subscriber)
    end
  end
end
