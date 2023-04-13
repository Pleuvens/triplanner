defmodule TriplannerWeb.PlanCreateLive do
  use TriplannerWeb, :live_view

  def mount(%{"room_name" => room_name}, _token, socket) do
    {:ok, assign(socket, form: to_form(%{}), room_name: room_name)}
  end

  def handle_event("create_plan", params, socket) do
    Triplanner.add_plan_to_room(Triplanner.get_room(socket.assigns.room_name), params["name"], NaiveDateTime.from_iso8601!(params["hour"] <> ":00"), Integer.parse(params["duration"]) |> elem(0), nil)
    {:noreply, push_redirect(socket, to: "/#{socket.assigns.room_name}")}
  end

  def handle_event("prev_view", _params, socket) do
    {:noreply, push_redirect(socket, to: "/#{socket.assigns.room_name}")}
  end
end
