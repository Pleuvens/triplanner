defmodule Triplanner.ChatSup do
  # Automatically defines child_spec/1
  use DynamicSupervisor

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_child({room_name, id}) do
    DynamicSupervisor.start_child(__MODULE__,
      %{
        id: Triplanner.Chat,
        start: {Triplanner.Chat, :start_link, [String.to_atom(room_name), id]}
      })
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
