defmodule TaskTrackerWeb.ManagementController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Managements
  alias TaskTracker.Managements.Management

  action_fallback TaskTrackerWeb.FallbackController

  def index(conn, _params) do
    managements = Managements.list_managements()
    render(conn, "index.json", managements: managements)
  end

  def create(conn, %{"management" => management_params}) do
    with {:ok, %Management{} = management} <- Managements.create_management(management_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.management_path(conn, :show, management))
      |> render("show.json", management: management)
    end
  end

  def show(conn, %{"id" => id}) do
    management = Managements.get_management!(id)
    render(conn, "show.json", management: management)
  end

  def update(conn, %{"id" => id, "management" => management_params}) do
    management = Managements.get_management!(id)

    with {:ok, %Management{} = management} <- Managements.update_management(management, management_params) do
      render(conn, "show.json", management: management)
    end
  end

  def delete(conn, %{"id" => id}) do
    management = Managements.get_management!(id)

    with {:ok, %Management{}} <- Managements.delete_management(management) do
      send_resp(conn, :no_content, "")
    end
  end
end
