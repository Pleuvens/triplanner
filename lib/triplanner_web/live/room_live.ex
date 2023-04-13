defmodule TriplannerWeb.RoomLive do
  use TriplannerWeb, :live_view

  def mount(%{"room_name" => room_name}, _token, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 30000)

    plans = Triplanner.get_room_info(room_name)
    {:ok, assign(socket, :room, %{name: room_name, plans: plans})}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 30000)
    plans = Triplanner.get_room_info(socket.assigns.room.name)
    {:noreply, assign(socket, :room, %{name: socket.assigns.room.name, plans: plans})}
  end

  def handle_event("update_plan", %{"room" => room, "plan" => plan}, socket) do
    {:noreply, push_redirect(socket, to: "/#{room}/#{plan}/edit")}
  end

  def handle_event("create_plan", %{"room" => room}, socket) do
    {:noreply, push_redirect(socket, to: "/#{room}/create")}
  end

  def handle_event("prev_view", _params, socket) do
    {:noreply, push_redirect(socket, to: "/")}
  end
end
