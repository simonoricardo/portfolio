defmodule Website.Blog do
  use NimblePublisher,
    build: Website.Post,
    from: "./posts/**/*.md",
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  def all_posts, do: @posts

  def by_year(posts) do
    Enum.reduce(get_years_with_posts(posts), %{}, fn year, acc ->
      posts =
        Enum.map(posts, fn post ->
          if post_year(post) == year do
            post
          end
        end)
        |> Enum.reject(&is_nil(&1))

      Map.put(acc, year, posts)
    end)
  end

  def get_years_with_posts(posts) do
    Enum.reduce(posts, [], fn post, acc ->
      post_year = post_year(post)

      if not Enum.member?(acc, post_year) do
        [post_year | acc]
      else
        acc
      end
    end)
    |> Enum.sort(:desc)
  end

  defp post_year(post), do: Date.to_string(post.date) |> String.slice(0, 4)
end
