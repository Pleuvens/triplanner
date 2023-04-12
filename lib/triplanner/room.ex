defmodule Triplanner.Room do
  use Ecto.Schema

  schema "rooms" do
    field :name, :string
    has_many :plans, Triplanner.Plan
  end

  def changeset(room, params \\ %{}) do
    room
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.validate_required([:name])
  end
end
