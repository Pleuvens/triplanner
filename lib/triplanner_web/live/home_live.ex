defmodule TriplannerWeb.HomeLive do
  use TriplannerWeb, :live_view

  def mount(_params, token, socket) do
    {:ok, assign(socket, form: to_form(%{}))}
  end

  def handle_event("save", %{"name" => name}, socket) do    
    {:noreply, push_redirect(socket, to: "/#{name}")}
  end
end
