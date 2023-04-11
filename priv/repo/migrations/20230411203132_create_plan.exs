defmodule Triplanner.Repo.Migrations.CreatePlan do
  use Ecto.Migration

  def change do
    create table(:plans) do
      add :name, :string
      add :hour, :naive_datetime
      add :duration, :integer
      add :notes, :string 
    end
  end
end
