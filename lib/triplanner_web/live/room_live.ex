defmodule TriplannerWeb.RoomLive do
  use TriplannerWeb, :live_view

  def mount(%{"room_name" => room_name}, _token, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 3000)

    pid = case Triplanner.ChatSup.start_child({room_name, socket.id}) do
      {:ok, p_id} -> p_id
      {:error, {:already_started, p_id}} ->
        GenServer.cast(String.to_atom(room_name), {:add_socket_id, socket.id})
        p_id
    end

    plans = Triplanner.get_room_info(room_name)
    {:ok, assign(socket, :room, %{name: room_name, plans: plans, pid: pid})}
  end

  def terminate(_reason, socket) do
    count = GenServer.call(String.to_atom(socket.assigns.room.name), {:remove_socket_id, socket.id})
    if count == 0 do
      DynamicSupervisor.terminate_child(Triplanner.ChatSup, socket.assigns.room.pid)
    end
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 3000)
    plans = Triplanner.get_room_info(socket.assigns.room.name)
    {:noreply, assign(socket, :room, %{name: socket.assigns.room.name, plans: plans, pid: socket.assigns.room.pid})}
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
