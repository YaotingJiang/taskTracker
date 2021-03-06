defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Users.User


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :tasks, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
