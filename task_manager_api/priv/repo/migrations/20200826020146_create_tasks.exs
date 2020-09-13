defmodule TaskManagerApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :user_id, :integer

      timestamps()
    end

    create unique_index(:tasks, [:title])
  end
end
