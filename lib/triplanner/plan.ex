defmodule Triplanner.Plan do
  use Ecto.Schema

  schema "plans" do
    field :name, :string
    field :hour, :naive_datetime
    field :duration, :integer
    field :notes, :string
  end

  def changeset(plan, params \\ %{}) do
    plan
    |> Ecto.Changeset.cast(params, [:name, :hour, :duration, :notes])
    |> Ecto.Changeset.validate_required([:name])
  end
end
