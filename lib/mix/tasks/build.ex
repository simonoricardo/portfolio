defmodule Mix.Tasks.Build do
  use Mix.Task
  require Logger

  @impl Mix.Task
  def run(_args) do
    {micro, :ok} =
      :timer.tc(fn ->
        Website.build()
      end)

    ms = micro / 1000
    IO.puts("⚡ Posts built in #{ms}ms")
  end
end
