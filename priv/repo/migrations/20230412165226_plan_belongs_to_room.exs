defmodule Triplanner.Repo.Migrations.PlanBelongsToRoom do
  use Ecto.Migration

  def change do
    alter table(:plans) do
      add :room_id, references(:rooms)
    end
  end
end
