defmodule Mix.Tasks.Files do
  use Mix.Task
  @impl Mix.Task

  require Logger

  def run(_args) do
    fonts()
    photos()
    resume()
  end

  @source_path "../../../assets/fonts"
  @destination_path "../../../output/assets/fonts"
  defp fonts do
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
  @full_width 3000
  defp photos do
    {micro, :ok} =
      :timer.tc(fn ->
        File.mkdir_p!("./output/assets/photos")

        source_path = Path.expand(@source_path, __DIR__)
        destination_path = Path.expand(@destination_path, __DIR__)

        with {:ok, data} <- File.ls(source_path) do
          IO.puts("Creating #{length(data)} optimized images and thumbnails...")

          data
          |> Enum.sort(:desc)
          |> Enum.with_index()
          |> Enum.each(fn
            {".git", _} ->
              nil

            {file, index} ->
              "#{source_path}/#{file}"
              |> Vix.Vips.Operation.thumbnail!(@thumbnail_width)
              |> Vix.Vips.Image.write_to_file("#{destination_path}/#{index}-tb.webp")

              "#{source_path}/#{file}"
              |> Vix.Vips.Operation.thumbnail!(@full_width)
              |> Vix.Vips.Image.write_to_file("#{destination_path}/#{index}.webp")
          end)
        end
      end)

    ms = micro / 1000
    IO.puts("⚡ Images optimized ans transfered in #{ms}ms")
  end

  @source_path "../../../assets"
  @destination_path "../../../output/assets"
  @fr "cv-fr.pdf"
  @en "cv-en.pdf"
  defp resume() do
    source_path = Path.expand(@source_path, __DIR__)
    destination_path = Path.expand(@destination_path, __DIR__)

    File.cp("#{source_path}/#{@fr}", "#{destination_path}/#{@fr}")
    File.cp("#{source_path}/#{@en}", "#{destination_path}/#{@en}")
  end
end
