defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    manager_ids = TaskTracker.Managements.get_managers_ids()
    tasks = TaskTracker.Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks, manager_ids: manager_ids)
  end

  def usertasks(conn, _params) do
    tasks = TaskTracker.Tasks.list_tasks()
    changeset = TaskTracker.Tasks.changeset(%TaskTracker.Tasks.Task{})
    render(conn, 'usertasks.html', tasks: tasks, changeset: changeset)
  end
end
