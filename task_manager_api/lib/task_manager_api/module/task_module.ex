defmodule TaskManagerApi.Module.TaskModule do

  import Ecto.Query
  alias TaskManagerApi.{Repo, Schema.Task}

  def create(params) do
    %Task{}
    |> Task.changeset(params)
    |> Repo.insert
  end

  def update(%Task{} = user, attrs) do
    user
    |> Task.changeset(attrs)
    |> Repo.update
  end

  def findAllByUser(user_id) do
    query = from(task in Task, where: task.user_id == ^user_id);
    Repo.all(query)
  end
  def findById!(id), do: Repo.get!(Task, id)

  def delete(%Task{} = task) do
    Repo.delete(task)
  end

end
