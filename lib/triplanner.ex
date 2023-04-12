defmodule Triplanner do
  @moduledoc """
  Triplanner keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  import Ecto.Query

  def get_room_info(room_name) do
    from(Triplanner.Plan, as: :plan)
    |> join(:left, [plan: plan], room in assoc(plan, :room), as: :room)
    |> where([room: room], room.name == ^room_name)
    |> Triplanner.Repo.all()
  end

  def create_room(room_name) do
    Triplanner.Repo.insert!(%Triplanner.Room{name: room_name})
  end

  def add_plan_to_room(room, plan_name) do
    plan = Ecto.build_assoc(room, :plans, %Triplanner.Plan{name: plan_name})
    Triplanner.Repo.insert(plan)
  end
end
