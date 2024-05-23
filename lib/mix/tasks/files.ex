defmodule Mix.Tasks.Files do
  use Mix.Task
  @impl Mix.Task

  require Logger

  def run(_args) do
    fonts()
    photos()
  end

  @source_path "../../../assets/fonts"
  @destination_path "../../../output/assets/fonts"
  def fonts do
    {micro, :ok} =
      :timer.tc(fn ->
        File.mkdir_p!("./output/assets/fonts")

        source_path = Path.expand(@source_path, __DIR__)
        destination_path = Path.expand(@destination_path, __DIR__)

        with {:ok, data} <- File.ls(source_path) do
          Enum.each(data, &File.cp("#{source_path}/#{&1}", "#{destination_path}/#{&1}"))
        end
      end)

    ms = micro / 1000
    IO.puts("⚡ Fonts transfered in #{ms}ms")
  end

  @source_path "../../../assets/photos"
  @destination_path "../../../output/assets/photos"
  @thumbnail_width 1000
  def photos do
    {micro, :ok} =
      :timer.tc(fn ->
        File.mkdir_p!("./output/assets/photos")

        source_path = Path.expand(@source_path, __DIR__)
        destination_path = Path.expand(@destination_path, __DIR__)

        with {:ok, data} <- File.ls(source_path) do
          IO.puts("Creating #{length(data)} image thumbnails...")

          data
          |> Enum.sort(:desc)
          |> Enum.with_index()
          |> Enum.each(fn {file, index} ->
            "#{source_path}/#{file}"
            |> Vix.Vips.Operation.thumbnail!(@thumbnail_width)
            |> Vix.Vips.Image.write_to_file("#{destination_path}/#{index}-tb.webp")

            IO.puts("Copying and renaming #{file} into the bundle...")
            File.cp("#{source_path}/#{file}", "#{destination_path}/#{index}.webp")
          end)
        end
      end)

    ms = micro / 1000
    IO.puts("⚡ Images optimized ans transfered in #{ms}ms")
  end
end
