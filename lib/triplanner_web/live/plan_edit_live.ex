defmodule TriplannerWeb.PlanEditLive do
  use TriplannerWeb, :live_view

  def mount(%{"room_name" => room_name, "plan_id" => plan_id}, _token, socket) do
    plan = Triplanner.get_plan(plan_id) |> Ecto.Changeset.change() |> to_form
    {:ok, assign(socket, form: plan, room_name: room_name)}
  end

  def handle_event("update_plan", params, socket) do
    plan = params["plan"]

    date = case plan["hour"] do
      "" -> nil
      date_time -> NaiveDateTime.from_iso8601!(date_time <> ":00")
    end

    duration = case plan["duration"] do
      "" -> nil
      value -> Integer.parse(value) |> elem(0)
    end

    Triplanner.update_plan(socket.assigns.form.data.id, plan["name"], date, duration, nil)
    {:noreply, push_redirect(socket, to: "/#{socket.assigns.room_name}")}
  end

  def handle_event("delete_plan", _params, socket) do
    Triplanner.delete_plan(socket.assigns.form.data.id)
    {:noreply, push_redirect(socket, to: "/#{socket.assigns.room_name}")}
  end

  def handle_event("prev_view", _params, socket) do
    {:noreply, push_redirect(socket, to: "/#{socket.assigns.room_name}")}
  end
end
