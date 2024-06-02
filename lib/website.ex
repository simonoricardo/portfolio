defmodule Website do
  use Phoenix.Component
  import Phoenix.HTML

  alias Website.Blog
  alias Website.Photo
  alias Website.Components
  alias Website.Icons

  embed_templates("components/*")

  def layout(assigns) do
    ~H"""
    <html class="scroll-smooth" lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="/assets/app.css" />
        <link rel="stylesheet" href="/assets/css/glightbox.css" />
        <script
          type="text/javascript"
          src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"
        >
        </script>
        <script>
          function enableBtn() {
            document.getElementById("submit").disabled = false;
          }
          function disableBtn() {
            document.getElementById("submit").disabled = true;
          }
        </script>
        <script src="https://www.google.com/recaptcha/api.js" async defer>
        </script>
        <script type="text/javascript" src="/assets/glightbox.js" />
        <script type="text/javascript" src="/assets/app.js" defer />
      </head>
      <body class="base bg-zinc-100 text-zinc-700 font-mono">
        <.nav />
        <main class="relative px-8">
          <%= render_slot(@inner_block) %>
        </main>
      </body>
    </html>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <.intro />
      <.about />
      <.posts />
      <.photos />
      <.contact_form />
    </.layout>
    """
  end

  def post(assigns) do
    ~H"""
    <.layout>
      <%= raw(@post.body) %>
    </.layout>
    """
  end

  @output_dir "./output"
  def build() do
    File.mkdir_p!(@output_dir)
    posts = Blog.all_posts()

    render_file("index.html", index(%{posts: posts}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.path, post(%{post: post}))
    end

    :ok
  end

  defp render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end
end
