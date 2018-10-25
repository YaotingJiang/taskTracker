defmodule TaskTracker.Timeblocks.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "timeblocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(timeblock, attrs) do
    attrs = create_time_block(attrs)
    timeblock
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :end, :task_id])
  end

  def create_time_block(attrs) do

    endtime = convert(attrs["end"])
    starttime = convert(attrs["start"])
    task_id = attrs["task_id"]

    %{
      start: starttime,
      end: endtime,
      task_id: task_id
    }
  end

  defp convert(time) do
    # time = String.split(time, ["-", " ", ":", ".", "T"])
    {:ok, time} = NaiveDateTime.from_iso8601(time)
   time
  end
end
