defmodule Triplanner.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Triplanner.Repo

      import Ecto
      import Ecto.Query
      import Triplanner.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Triplanner.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Triplanner.Repo, {:shared, self()})
    end

    :ok
  end
end
