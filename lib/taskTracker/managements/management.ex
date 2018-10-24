defmodule TaskTracker.Managements.Management do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Users.User


  schema "managements" do
    # field :manager_id, :id
    # field :underling_id, :id

    belongs_to :manager, TaskTracker.Users.User
    belongs_to :underling, TaskTracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(management, attrs) do
    management
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
  end
end
