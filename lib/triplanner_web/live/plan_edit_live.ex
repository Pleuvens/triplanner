defmodule TriplannerWeb.PlanEditLive do
  use TriplannerWeb, :live_view

  def mount(%{"room_name" => room_name, "plan_id" => plan_id}, _token, socket) do
    plan = Triplanner.get_plan(plan_id) |> Ecto.Changeset.change() |> to_form
    IO.inspect(plan)
    {:ok, assign(socket, form: plan, room_name: room_name)}
  end

  def handle_event("update_plan", params, socket) do
    plan = params["plan"]
    Triplanner.update_plan(socket.assigns.form.data.id, plan["name"], NaiveDateTime.from_iso8601!(plan["hour"] <> ":00"), Integer.parse(plan["duration"]) |> elem(0), nil)
    {:noreply, push_redirect(socket, to: "/#{socket.assigns.room_name}")}
  end

  def handle_event("prev_view", _params, socket) do
    {:noreply, push_redirect(socket, to: "/#{socket.assigns.room_name}")}
  end
end
