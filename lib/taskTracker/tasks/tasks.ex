defmodule TaskTracker.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:user)
    # |> Repo.preload(:timeblocks)
    # Repo.all from t in Task, preload: [:user]
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_task!(id), do: Repo.get!(Task, id)
  def get_task!(id) do
    Repo.get!(Task, id)
    |> Repo.preload(:user)
    |> Repo.preload(:timeblocks)
    # Repo.one! from t in Task, where: t.id == ^id, preload: [:user]
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  # def filterout_underlings_tasks(user_id) do
  #   Repo.all(from t in Task,
  #     join: m in Management,
  #     where: t.user_id == m.underling_id,
  #     where: m.manager_id == ^user_id)
  #   |> Repo.uniq()
  # end
  #
  # def get_managers_ids do
  #   Repo.all(from m in Management,
  #   select: m.manager_id)
  # end
  #
  #
  # def map_users_with_id(user_id) do
  #   Repo.all(from m in Management,
  #   where: m.manager_id == ^user_id)
  #   |> Enum.map(&({&1.underling_id, &1.id}))
  #   |> Enum.into(%{})
  # end
end
