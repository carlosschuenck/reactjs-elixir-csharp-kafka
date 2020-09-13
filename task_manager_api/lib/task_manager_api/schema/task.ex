defmodule TaskManagerApi.Schema.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :user_id])
    |> unique_constraint(:title)
  end
end
