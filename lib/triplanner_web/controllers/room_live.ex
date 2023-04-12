defmodule TriplannerWeb.RoomLive do
  use TriplannerWeb, :live_view

  def render(assigns) do
    ~H"""
      Room name: <%= @room_name %>
    """
  end

  def mount(%{"room_name" => room_name}, _token, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 30000)

    case Triplanner.get_room_info(room_name) do
      {:ok, {room, plans}} ->
        IO.inspect(plans)
        {:ok, assign(socket, :room_name, room.name)}

      {:error, _reason} ->
        {:ok, redirect(socket, to: "/error")}
    end
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 30000)
    {:ok, {room, plans}} = Triplanner.get_room_info(socket.assigns.room_name)
    IO.inspect(plans)
    {:noreply, assign(socket, :room_name, room.name)}
  end
end
