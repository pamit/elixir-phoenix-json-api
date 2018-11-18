defmodule BusiApiWeb.BusinessControllerTest do
  use BusiApiWeb.ConnCase

  alias BusiApi.Repo
  alias BusiApi.Directory
  alias BusiApi.Directory.Business
  alias BusiApi.Accounts
  alias BusiApiWeb.Auth.Guardian

  @create_attrs %{description: "some description", name: "some name", tag: "some tag"}
  @update_attrs %{description: "some updated description", name: "some updated name", tag: "some updated tag"}
  @invalid_attrs %{description: nil, name: nil, tag: nil}

  def fixture(:business) do
    {:ok, business} = Directory.create_business(@create_attrs)
    business
  end

  setup %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{email: "user@business.com", password: "123456"})
    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    conn = conn 
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", "Bearer " <> token)
    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all businesses", %{conn: conn} do
      # IO.inspect(get_req_header(conn, "authorization"))
      conn = get conn, business_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create business" do
    test "renders business when data is valid", %{conn: conn} do
      conn = post conn, business_path(conn, :create), business: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      assert json_response(conn, 201)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name",
        "tag" => "some tag",
        "date" => NaiveDateTime.to_string(Directory.get_business!(id).inserted_at)
      }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, business_path(conn, :create), business: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update business" do
    setup [:create_business]

    test "renders business when data is valid", %{conn: conn, business: %Business{id: id} = business} do
      conn = put conn, business_path(conn, :update, business), business: @update_attrs
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name",
        "tag" => "some updated tag",
        "date" => NaiveDateTime.to_string(Directory.get_business!(id).inserted_at)
      }
    end

    test "renders errors when data is invalid", %{conn: conn, business: business} do
      conn = put conn, business_path(conn, :update, business), business: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete business" do
    setup [:create_business]

    test "deletes chosen business", %{conn: conn, business: business} do
      conn = delete conn, business_path(conn, :delete, business)
      assert response(conn, 204)
      assert Repo.get(Business, business.id) == nil
    end
  end

  defp create_business(_) do
    business = fixture(:business)
    {:ok, business: business}
  end
end
