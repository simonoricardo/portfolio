defmodule Simon.Blog do
  alias Simon.Post

  use NimblePublisher,
    build: Post,
    from: "./posts/**/*.md",
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  # And finally export them
  def all_posts, do: @posts
end
