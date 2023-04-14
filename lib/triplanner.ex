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
    |> order_by([asc: :hour])
    |> join(:left, [plan: plan], room in assoc(plan, :room), as: :room)
    |> where([room: room], room.name == ^room_name)
    |> Triplanner.Repo.all()
    |> Enum.group_by(fn p ->
        if p.hour != nil do
          String.pad_leading(inspect(p.hour.day), 2, "0") <> " / " <> String.pad_leading(inspect(p.hour.month), 2, "0") <> " / " <> inspect(p.hour.year)
        end
      end)
  end

  def get_room(room_name) do
    Triplanner.Repo.get_by(Triplanner.Room, name: room_name)
  end

  def get_plan(plan_id) do
    Triplanner.Repo.get_by(Triplanner.Plan, id: plan_id)
  end

  def create_room(room_name) do
    Triplanner.Repo.insert!(%Triplanner.Room{name: room_name})
  end

  def add_plan_to_room(room, plan_name, hour \\ nil, duration \\ nil, notes \\ nil) do
    plan = Ecto.build_assoc(room, :plans, %Triplanner.Plan{name: plan_name, hour: hour, duration: duration, notes: notes})
    Triplanner.Repo.insert(plan)
  end

  def update_plan(id, plan_name, hour, duration, notes) do
    Triplanner.Repo.get_by(Triplanner.Plan, id: id)
    |> Ecto.Changeset.change(%{name: plan_name, hour: hour, duration: duration, notes: notes})
    |> Triplanner.Repo.update()
  end

  def delete_plan(id) do
    Triplanner.Repo.get_by(Triplanner.Plan, id: id)
    |> Triplanner.Repo.delete()
  end

  def get_messages(room_name) do
    GenServer.call(String.to_atom(room_name), {:get_messages})
  end

  def send_message(room_name, msg) do
    GenServer.cast(String.to_atom(room_name), {:push_message, msg})
  end
end
