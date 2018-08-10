defmodule SubscriptionBackend.UtilsTest do
  use SubscriptionBackendWeb.ConnCase

  alias SubscriptionBackend.Utils
  alias SubscriptionBackend.Newsletter

  @invalid_domain %{email: "some.email@duck2.xyz", first_name: "some first_name", last_name: "some last_name"}
  describe "utils" do

    def subscriber_fixture(attrs \\ %{}) do
      {:ok, subscriber} =
        attrs
        |> Enum.into(@invalid_domain)
        |> Newsletter.create_subscriber()

      subscriber
    end

    test "handle_changeset_errors should return proper object", %{conn: conn} do
      assert {:error, %Ecto.Changeset{} = changeset} = Newsletter.create_subscriber(@invalid_domain)

      assert [%{email: "Invalid email domain"}] = Utils.handle_changeset_errors(changeset.errors)

    end

  end

end
