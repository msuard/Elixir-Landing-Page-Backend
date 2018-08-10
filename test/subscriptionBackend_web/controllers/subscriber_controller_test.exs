defmodule SubscriptionBackendWeb.SubscriberControllerTest do
  use SubscriptionBackendWeb.ConnCase

  alias SubscriptionBackend.Newsletter
  alias SubscriptionBackend.Newsletter.Subscriber

  @create_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil}

  def fixture(:subscriber) do
    {:ok, subscriber} = Newsletter.create_subscriber(@create_attrs)
    subscriber
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all subscribers", %{conn: conn} do
      conn = get conn, subscriber_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create subscriber" do
    test "renders subscriber when data is valid", %{conn: conn} do
      conn = post conn, subscriber_path(conn, :create), subscriber: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, subscriber_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "email" => "some email",
        "first_name" => "some first_name",
        "last_name" => "some last_name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, subscriber_path(conn, :create), subscriber: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update subscriber" do
    setup [:create_subscriber]

    test "renders subscriber when data is valid", %{conn: conn, subscriber: %Subscriber{id: id} = subscriber} do
      conn = put conn, subscriber_path(conn, :update, subscriber), subscriber: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, subscriber_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "email" => "some updated email",
        "first_name" => "some updated first_name",
        "last_name" => "some updated last_name"}
    end

    test "renders errors when data is invalid", %{conn: conn, subscriber: subscriber} do
      conn = put conn, subscriber_path(conn, :update, subscriber), subscriber: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete subscriber" do
    setup [:create_subscriber]

    test "deletes chosen subscriber", %{conn: conn, subscriber: subscriber} do
      conn = delete conn, subscriber_path(conn, :delete, subscriber)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, subscriber_path(conn, :show, subscriber)
      end
    end
  end

  defp create_subscriber(_) do
    subscriber = fixture(:subscriber)
    {:ok, subscriber: subscriber}
  end
end
