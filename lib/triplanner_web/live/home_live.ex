defmodule TriplannerWeb.HomeLive do
  use TriplannerWeb, :live_view

  def mount(_params, _token, socket) do
    {:ok, assign(socket, form: to_form(%{}), error_create: nil, error_join: nil)}
  end

  def handle_event("join_room", %{"name" => name}, socket) do    
    case Triplanner.get_room(name) do
      nil ->
        IO.inspect("room not found")
        {:noreply, assign(socket, form: to_form(%{}), error_create: nil, error_join: "Room '#{name}' not found !")}
      _ -> {:noreply, push_redirect(socket, to: "/#{name}")}
    end
  end

  def handle_event("create_join_room", %{"name" => name}, socket) do    
    try do
      Triplanner.create_room(name)
      {:noreply, push_redirect(socket, to: "/#{name}")}
    rescue
      _ -> {:noreply, assign(socket, form: to_form(%{}), error_create: "Room '#{name}' already exists !", error_join: nil)}
    end
  end
end
