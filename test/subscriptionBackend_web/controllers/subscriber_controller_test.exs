defmodule SubscriptionBackendWeb.SubscriberControllerTest do
  use SubscriptionBackendWeb.ConnCase

  alias SubscriptionBackend.Newsletter
  alias SubscriptionBackend.Newsletter.Subscriber

  @create_attrs %{email: "some.email@valid.domain.xyz", first_name: "some first_name", last_name: "some last_name"}
  @missing_attrs %{email: nil, first_name: nil, last_name: nil}
  @invalid_email %{email: "invalid email", first_name: "some first_name", last_name: "some last_name"}
  @invalid_first_name %{email: "some.email@valid.domain.xyz", first_name: 123456, last_name: "some last_name"}
  @invalid_last_name %{email: "some.email@valid.domain.xyz", first_name: "some first_name", last_name: 123456}
  @invalid_domain %{email: "some.email@duck2.xyz", first_name: "some first_name", last_name: "some last_name"}


  def fixture(:subscriber) do
    {:ok, subscriber} = Newsletter.create_subscriber(@create_attrs)
    subscriber
  end

  describe "create subscriber" do
    test "creates subscriber when data is valid", %{conn: conn} do

      conn = post conn, "/subscribe/new", @create_attrs

      assert  %{
                 "params" => %{
                   "email" => "some.email@valid.domain.xyz",
                   "first_name" => "some first_name",
                   "last_name" => "some last_name"
                 },
                 "status" => "Success"
               }
                = json_response(conn, 201)
    end

    test "returns proper error message when attributes are missing", %{conn: conn} do

      conn = post conn, "/subscribe/new", @missing_attrs

      assert %{
               "error" => [
                 %{"first_name" => "Missing field"},
                 %{"last_name" => "Missing field"},
                 %{"email" => "Missing field"}
               ],
               "params" => %{
                 "email" => nil,
                 "first_name" => nil,
                 "last_name" => nil
               }
             }
             = json_response(conn, 400)
    end

    test "returns proper error message when email is invalid", %{conn: conn} do

      conn = post conn, "/subscribe/new", @invalid_email

      assert %{
               "error" => [%{"email" => "Invalid email format"}],
               "params" => %{
                 "email" => "invalid email",
                 "first_name" => "some first_name",
                 "last_name" => "some last_name"
               }
             }
             = json_response(conn, 400)
    end

    test "returns proper error message when first_name is invalid", %{conn: conn} do

      conn = post conn, "/subscribe/new", @invalid_first_name

      assert %{
               "error" => [%{"first_name" => "is invalid"}],
               "params" => %{
                 "email" => "some.email@valid.domain.xyz",
                 "first_name" => 123456,
                 "last_name" => "some last_name"
               }
             }
             = json_response(conn, 400)
    end

    test "returns proper error message when last_name is invalid", %{conn: conn} do

      conn = post conn, "/subscribe/new", @invalid_last_name

      assert %{
               "error" => [%{"last_name" => "is invalid"}],
               "params" => %{
                 "email" => "some.email@valid.domain.xyz",
                 "first_name" => "some first_name",
                 "last_name" => 123456
               }
             }
             = json_response(conn, 400)
    end

    test "returns proper error message when domain is invalid", %{conn: conn} do

      conn = post conn, "/subscribe/new", @invalid_domain

      assert %{
               "error" => [%{"email" => "Invalid email domain"}],
               "params" => %{
                 "email" => "some.email@duck2.xyz",
                 "first_name" => "some first_name",
                 "last_name" => "some last_name"
               }
             }
             = json_response(conn, 400)
    end

  end

  defp create_subscriber(_) do
    subscriber = fixture(:subscriber)
    {:ok, subscriber: subscriber}
  end

end
