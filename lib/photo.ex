defmodule Website.Photo do
  @photos_path "../output/assets/photos"
  @relative_path "./assets/photos"

  def all_photos() do
    photos_path = Path.expand(@photos_path, __DIR__)

    with {:ok, data} <- File.ls(photos_path) do
      {thumbnails, photos} = Enum.split_with(data, &String.contains?(&1, "-tb"))

      photos
      |> Enum.sort(&(photo_num(&1) <= photo_num(&2)))
      |> Enum.map(fn photo ->
        thumbnail =
          Enum.find(thumbnails, &(String.replace(photo, ".webp", "-tb.webp") == &1))

        %{photo: "#{@relative_path}/#{photo}", thumbnail: "#{@relative_path}/#{thumbnail}"}
      end)
    end
  end

  defp photo_num(filename) do
    filename
    |> String.split(".", parts: 2)
    |> Enum.at(0)
    |> String.to_integer()
  end
end
