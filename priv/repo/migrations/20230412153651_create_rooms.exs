defmodule Triplanner.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
    end

    create unique_index(:rooms, [:name])
  end
end
