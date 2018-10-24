defmodule TaskTracker.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.Users.User
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Managements.Management
  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
    # |> Repo.preload(:manager)
    # |> Repo.preload(:underling)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
#   def get_user!(id) do
 #    Repo.get!(User, id)
  #   |> Repo.preload(:task)
  # end
  def get_user!(id), do: Repo.get!(User, id)

  # below get_user!
 # def get_user(id), do: Repo.get(User, id)
   def get_user(id) do
     Repo.get(User, id)
     |> Repo.preload(:tasks)
     |> Repo.preload(:manager_manages)
     |> Repo.preload(:manager)
     |> Repo.preload(:underlings_managed)
     |> Repo.preload(:underling)
   end



  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # given user_id is an underling's id and returns this underling's manager
  def get_underling_manager(user_id) do
    # IO.puts("current user id")
    # IO.inspect(user_id)
    Repo.all(from u in User,
      join: m in Management,
      where: u.id == m.manager_id,
      where: m.underling_id == ^user_id,
      select: {u.id, u.name, u.email})
  end

  # given user_id is a manager's id and returns this manager's underlings
  def get_managers_underling(user_id) do
    Repo.all(from u in User,
      join: m in Management,
      where: m.underling_id == u.id,
      where: m.manager_id == ^user_id,
      select: {u.id, u.name, u.email})
  end

  def get_unmanaged_users(user_id) do
    ids = Repo.all(from m in Management,
      select: m.underling_id)
    unmanged_users = Repo.all(from u in User,
      where: not u.id in ^ids,
      select: {u.id, u.name, u.email})
    Enum.concat(unmanged_users, get_managers_underling(user_id))
    |> Enum.uniq()
  end
end
