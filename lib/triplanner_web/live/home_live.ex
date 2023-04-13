defmodule TriplannerWeb.HomeLive do
  use TriplannerWeb, :live_view

  def mount(_params, _token, socket) do
    {:ok, assign(socket, form: to_form(%{}))}
  end

  def handle_event("join_room", %{"name" => name}, socket) do    
    case Triplanner.get_room(name) do
      nil ->
        IO.inspect("room not found")
        {:noreply, socket}
      _ -> {:noreply, push_redirect(socket, to: "/#{name}")}
    end
  end

  def handle_event("create_join_room", %{"name" => name}, socket) do    
    Triplanner.create_room(name)
    {:noreply, push_redirect(socket, to: "/#{name}")}
  end
end
