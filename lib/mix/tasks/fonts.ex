defmodule Mix.Tasks.Fonts do
  use Mix.Task
  @impl Mix.Task

  require Logger

  def run(_args) do
    source_path = Path.expand("../../../assets/fonts", __DIR__)
    File.mkdir_p!("./output/assets/fonts")
    dest_path = Path.expand("../../../output/assets/fonts", __DIR__)

    with {:ok, data} <- File.ls(source_path) do
      Enum.each(data, &File.cp("#{source_path}/#{&1}", "#{dest_path}/#{&1}"))
    end
  end
end
