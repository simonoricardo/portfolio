defmodule Website.Build do
  alias Website
  alias Website.{Blog, Components, Photo}

  @output_dir "./output"
  def run() do
    File.mkdir_p!(@output_dir)
    posts = Blog.all_posts()
    photos = Photo.all_photos()

    render_file("index.html", Website.index(%{posts: posts, photos: photos}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.path, Components.post(%{post: post}))
    end

    :ok
  end

  defp render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end
end
