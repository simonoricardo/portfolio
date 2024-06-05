%{
  title: "It's alive!",
  author: "Simon Ricard",
  tags: ~w(post blog portfolio elixir static markdown),
  description: "My blog is alive! How was it built?"
}
---

## It's alive! 
#### My very first post with my custom static site generator using Elixir.

I've seen many devs having their own little platforms for sharing their thoughts and ideas, and I decided that I could do the same here!

I've been mostly developing with Elixir for the past few years, and so I wanted to try and create a static site generated from markdown files with it.
The result is something that could be deployed litterally anywhere we can deploy static files (S3, Vercel, Github Pages, etc) while only writing Elixir, Markdown and *some* Javascript.

Here is the repo for the [portfolio itself](https://github.com/simonoricardo/portfolio).
Depending on when you'll be reading this article, this might very well still be a WIP.

### Key pieces

Here are the main pieces for this statically generated blog website.
- Elixir - of course
- [nimble_publisher](https://github.com/dashbitco/nimble_publisher) - this is what transforms our markdown into HTMl pages
- [phoenix_live_view](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html) - for the `Phoenix.Component` macro letting use composable function components within our website
- Tailwind - for styling
- [makeup](https://github.com/elixir-makeup/makeup) - for code block highlighting
- [vix](https://hexdocs.pm/vix/readme.html) - to create photos thumbnails and optimize them at build time

### How?

While I could go into lots of details with how this whole website has been created, here are the most important part.

This part is where we define the location of our posts, as well as the code highlighter that will be used:

```elixir
defmodule Website.Blog do
  use NimblePublisher,
    build: Website.Post,
    from: "./posts/**/*.md",
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  def all_posts, do: @posts
  [...]
end
```

Here is where we will define what our post will look like, what its metadata will be and other things of interest:

```elixir
defmodule Website.Post do
  @enforce_keys [:id, :author, :title, :body, :description, :tags, :date, :path]
  defstruct [:id, :author, :title, :body, :description, :tags, :date, :path]

  def build(filename, attrs, body) do
    path = Path.rootname(filename)
    [year, month_day_id] = path |> Path.split() |> Enum.take(-2)

    path = path <> ".html"
    [month, day, id] = String.split(month_day_id, "-", parts: 3)

    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    struct!(__MODULE__, [id: id, date: date, body: body, path: path] ++ Map.to_list(attrs))
  end
end
```

This is where we actually convert the markdown to HTML.
We first fetch all of the posts and pass them down to the `index` page so that they can be listed eventually in a list.
Then, we will generate an html page for every single of of those posts.

```elixir
defmodule Website.Build do
  @output_dir "./output"
  def run() do
    File.mkdir_p!(@output_dir)
    posts = Website.Blog.all_posts()

    render_file("index.html", Website.index(%{posts: posts}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.path, Website.post(%{post: post}))
    end

    :ok
  end

  defp render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end
end
```

And that's it! We run this `run()` function via a mix task, along with the other stuff that needs to be generated (Tailwind, esbuild, etc).

There are some other stuff going on for the photos and the other sections, but I believe this is a lot less interesting.

If you want to take a look at the repo, feel free [to do so!](https://github.com/simonoricardo/portfolio)
