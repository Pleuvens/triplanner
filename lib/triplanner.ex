defmodule Triplanner do
  @moduledoc """
  Triplanner keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  require Ecto.Query

  def get_room_info(room_name) do
    case Triplanner.Room |> Triplanner.Repo.get_by(name: room_name) do
      nil -> {:error, nil}
      room ->
        plans = Triplanner.Plan |> Ecto.Query.where(room_id: ^room.id) |> Triplanner.Repo.all
        {:ok, {room, plans}}
    end
  end
end
