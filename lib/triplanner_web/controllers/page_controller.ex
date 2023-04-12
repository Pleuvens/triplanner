defmodule TriplannerWeb.PageController do
  use TriplannerWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def redirect_to_room(conn, params) do
    IO.inspect(params, label: "params redirect")
    redirect(conn, to: "/room/tata")
  end
end
