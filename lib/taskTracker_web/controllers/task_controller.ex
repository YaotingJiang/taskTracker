defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Managements.Management
  alias TaskTracker.Timeblocks.Timeblock

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    # tasks = Tasks.list_tasks()
    manager_ids = TaskTracker.Managements.get_managers_ids()
    tasks = TaskTracker.Managements.filterout_underlings_tasks(current_user.id)
    IO.puts("debug manager id")
    IO.puts inspect(manager_ids)
    render(conn, "index.html", tasks: tasks, manager_ids: manager_ids)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    # users = Enum.map(Users.list_users(), fn(user) -> user.email end)
     # user_id = get_session(conn, :user_id)
     # user_ctasks = Tasks.change_task(%Tasks.Task{
     #   user_id: user_id
     # })
     # changeset = TaskTracker.Timeblocks.change_timeblock(%Timeblock{
     #   task_id: task.id
     # })
     # IO.puts("debug changeset")
     # IO.inspect(changeset)
     timeblocks = TaskTracker.Timeblocks.show_timeblock(id)
     IO.puts("DEBUG HERE TIME")
     IO.inspect(timeblocks)
     manager = TaskTracker.Managements.get_managers_ids()
     render(conn, "show.html", task: task, manager: manager, timeblocks: timeblocks)
   # render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    current_user = conn.assigns[:current_user]
    render(conn, "edit.html", task: task, current_user: current_user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
