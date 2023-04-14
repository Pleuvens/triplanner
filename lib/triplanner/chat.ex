defmodule Triplanner.Chat do
  use GenServer

  def start_link(room_name, id) do
    GenServer.start_link(__MODULE__, id, name: room_name)
  end

  @impl true
  def init(id) do
    {:ok, %{messages: [], ids: [id]}}
  end

  @impl true
  def handle_cast({:push_message, msg}, state) do
    {:noreply, %{messages: state.messages ++ [msg], ids: state.ids}}
  end

  @impl true
  def handle_cast({:add_socket_id, id}, state) do
    {:noreply, %{messages: state.messages, ids: [id | state.ids]}}
  end

  @impl true
  def handle_call({:get_messages}, _from, state) do
    {:reply, state.messages, state}
  end

  @impl true
  def handle_call({:remove_socket_id, id}, _from, state) do
    new_ids = Enum.reject(state.ids, fn e -> e == id end)
    {:reply, length(new_ids), %{messages: state.messages, ids: new_ids}}
  end
end
