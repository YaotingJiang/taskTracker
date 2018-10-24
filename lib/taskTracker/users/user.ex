defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Managements.Management


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :tasks, TaskTracker.Tasks.Task
    has_one :manager_manages, Management, foreign_key: :manager_id
    has_many :underlings_managed, Management, foreign_key: :underling_id
    has_one :manager, through: [:manager_manages, :manager]
    has_many :underling, through: [:underlings_managed, :underling]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
