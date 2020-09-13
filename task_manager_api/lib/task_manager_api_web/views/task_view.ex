defmodule TaskManagerApiWeb.TaskView do
  use TaskManagerApiWeb, :view
  alias TaskManagerApiWeb.TaskView

  def render("list.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.id,
      title: task.title,
      description: task.description,
      user_id: task.user_id,
      created_at: NaiveDateTime.to_string(task.inserted_at)
    }
  end
end
