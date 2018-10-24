defmodule TaskTracker.ManagementsTest do
  use TaskTracker.DataCase

  alias TaskTracker.Managements

  describe "managements" do
    alias TaskTracker.Managements.Management

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def management_fixture(attrs \\ %{}) do
      {:ok, management} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Managements.create_management()

      management
    end

    test "list_managements/0 returns all managements" do
      management = management_fixture()
      assert Managements.list_managements() == [management]
    end

    test "get_management!/1 returns the management with given id" do
      management = management_fixture()
      assert Managements.get_management!(management.id) == management
    end

    test "create_management/1 with valid data creates a management" do
      assert {:ok, %Management{} = management} = Managements.create_management(@valid_attrs)
    end

    test "create_management/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Managements.create_management(@invalid_attrs)
    end

    test "update_management/2 with valid data updates the management" do
      management = management_fixture()
      assert {:ok, %Management{} = management} = Managements.update_management(management, @update_attrs)

      
    end

    test "update_management/2 with invalid data returns error changeset" do
      management = management_fixture()
      assert {:error, %Ecto.Changeset{}} = Managements.update_management(management, @invalid_attrs)
      assert management == Managements.get_management!(management.id)
    end

    test "delete_management/1 deletes the management" do
      management = management_fixture()
      assert {:ok, %Management{}} = Managements.delete_management(management)
      assert_raise Ecto.NoResultsError, fn -> Managements.get_management!(management.id) end
    end

    test "change_management/1 returns a management changeset" do
      management = management_fixture()
      assert %Ecto.Changeset{} = Managements.change_management(management)
    end
  end
end
