defmodule Triplanner.TriplannerTest do
  use Triplanner.RepoCase

  test "create room" do
    assert_raise Ecto.ChangeError, fn ->
      Triplanner.create_room(1)
    end

    # room with empty name not allowed
    assert_raise Postgrex.Error, fn ->
      Triplanner.create_room(nil)
    end

    Triplanner.create_room("unit_room")

    assert Triplanner.Repo.get_by(Triplanner.Room, name: "unit_room") != nil

    # two rooms with same name not allowed
    assert_raise Ecto.ConstraintError, fn ->
      Triplanner.create_room("unit_room")
    end
  end
end
