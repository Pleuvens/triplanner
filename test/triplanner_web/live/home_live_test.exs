defmodule TriplannerWeb.HomeLiveTest do
  use TriplannerWeb.ConnCase

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  test "create room", %{conn: conn} do
    conn = get(conn, "/")
    {:ok, view, html} = live(conn)

    assert String.contains?(html, ["Create room", "Join Room"])

    assert view
    |> element("#create_room")
    |> render_submit(%{"name" => "test"})
    |> follow_redirect(conn, "/test")
  end
end
