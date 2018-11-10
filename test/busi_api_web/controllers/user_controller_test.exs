defmodule BusiApiWeb.UserControllerTest do
  use BusiApiWeb.ConnCase

  alias BusiApi.Accounts

  @create_attrs %{email: "user@business.com", password: "some encrypted_password"}
  @invalid_attrs %{email: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert %{"email" => email} = json_response(conn, 201)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "user signin" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert %{"email" => email} = json_response(conn, 201)

      conn = post conn, user_path(conn, :signin), @create_attrs
      assert %{"token" => token} = json_response(conn, 201)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert %{"email" => email} = json_response(conn, 201)

      conn = post conn, user_path(conn, :signin), %{email: "user@business.com", password: ""}
      assert json_response(conn, 401)["errors"] != %{}
    end
  end
end
