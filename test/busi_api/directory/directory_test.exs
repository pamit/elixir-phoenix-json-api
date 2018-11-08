defmodule BusiApi.DirectoryTest do
  use BusiApi.DataCase

  alias BusiApi.Directory

  describe "businesses" do
    alias BusiApi.Directory.Business

    @valid_attrs %{description: "some description", name: "some name", tag: "some tag"}
    @update_attrs %{description: "some updated description", name: "some updated name", tag: "some updated tag"}
    @invalid_attrs %{description: nil, name: nil, tag: nil}

    def business_fixture(attrs \\ %{}) do
      {:ok, business} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_business()

      business
    end

    test "list_businesses/0 returns all businesses" do
      business = business_fixture()
      assert Directory.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business = business_fixture()
      assert Directory.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      assert {:ok, %Business{} = business} = Directory.create_business(@valid_attrs)
      assert business.description == "some description"
      assert business.name == "some name"
      assert business.tag == "some tag"
    end

    test "create_business/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_business(@invalid_attrs)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      assert {:ok, business} = Directory.update_business(business, @update_attrs)
      assert %Business{} = business
      assert business.description == "some updated description"
      assert business.name == "some updated name"
      assert business.tag == "some updated tag"
    end

    test "update_business/2 with invalid data returns error changeset" do
      business = business_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_business(business, @invalid_attrs)
      assert business == Directory.get_business!(business.id)
    end

    test "delete_business/1 deletes the business" do
      business = business_fixture()
      assert {:ok, %Business{}} = Directory.delete_business(business)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_business!(business.id) end
    end

    test "change_business/1 returns a business changeset" do
      business = business_fixture()
      assert %Ecto.Changeset{} = Directory.change_business(business)
    end
  end
end
