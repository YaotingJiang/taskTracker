defmodule TaskTrackerWeb.ManagementView do
  use TaskTrackerWeb, :view
  alias TaskTrackerWeb.ManagementView

  def render("index.json", %{managements: managements}) do
    %{data: render_many(managements, ManagementView, "management.json")}
  end

  def render("show.json", %{management: management}) do
    %{data: render_one(management, ManagementView, "management.json")}
  end

  def render("management.json", %{management: management}) do
    %{id: management.id}
  end
end
