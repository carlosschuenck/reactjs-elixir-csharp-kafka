defmodule TaskManagerApiWeb.TaskController do
  use TaskManagerApiWeb, :controller

  alias TaskManagerApi.Module.TaskModule
  alias TaskManagerApi.Schema.Task


  def create(conn, params) do
    case TaskModule.create(params) do
      {:ok, _} ->
        conn
        |> put_status(201)
        |> json(%{status: "created"})
      {:error, _} ->
        conn
        |> put_status(500)
        |> json(%{status: "Internal server error"})
    end
  end

  def update(conn, %{"id" => id} = task_params) do
    task = TaskModule.findById!(id);
    with {:ok, %Task{} = task } <- TaskModule.update(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def findByUserId(conn, %{"id" => id}) do
    tasks = TaskModule.findAllByUser(id)
    render(conn, "list.json", tasks: tasks)
  end

  def delete(conn, %{"id" => id}) do
    task = TaskModule.findById!(id)

    with {:ok, %Task{}} <- TaskModule.delete(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
