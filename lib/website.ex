defmodule Website do
  use Phoenix.Component
  import Phoenix.HTML

  alias Simon.Blog

  embed_templates("components/*")

  def layout(assigns) do
    ~H"""
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="/assets/app.css" />
        <script type="text/javascript" src="/assets/app.js" defer />
      </head>
      <body class="base bg-zinc-200 text-zinc-700 font-mono">
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
      <div class="my-48">
        <p class="text-3xl font-bold my-8">Hello!</p>
        <p>
          I am a full stack developer, with a passion for bringing people's ideas to life.
        </p>
        <p>
          I currently work mostly with <span class="font-bold">Elixir</span>, <span class="font-bold">React</span>,
          <span class="font-bold">React Native</span>
          and <span class="font-bold">Typescript</span>.
        </p>
        <p class="mt-4">
          I am Canadian, bilingual, have a passion for
          <a href="#" class="font-bold underline">photography</a>
          and previously worked as a <a
            href="https://www.jobbank.gc.ca/marketreport/summary-occupation/22706/ca"
            target="_blank"
            class="font-bold underline"
          >flight dispatcher</a>.
        </p>
      </div>

      <div class="mb-8" id="about">
        <h2 class="my-4">[about me]</h2>
        <p class="tracking-tight text-sm my-2">
          It all began a few years ago, when I was working as a <a
            href="https://www.jobbank.gc.ca/marketreport/summary-occupation/22706/ca"
            target="_blank"
            class="font-bold underline"
          >flight dispatcher</a>.
          Having worked for various Canadian airlines, I recognized the significant impact that the right tools can have on job effectiveness.
          When COVID-19 hit, I decided to switch careers and pursue software development to help businesses and individuals streamline
          processes and enhance efficiency.
        </p>
        <p class="tracking-tight text-sm my-2">
          I have since accumulated a few years of experience in software development and aim to continue working on projects that have a positive impact on the world.
        </p>
        <p class="tracking-tight my-6">
          >> Here is my resume <a href="cv-fr.pdf" target="_blank" class="font-bold underline">FR</a>
          / EN
        </p>
        <p class="tracking-tight text-sm my-2">
          If you wish to contact me, you may do so <a href="#" class="font-bold underline">here</a>,
        </p>
      </div>
      <div class="mb-8 my-16" id="posts">
        <h2 class="my-4">[posts]</h2>
        <ul>
          <li :for={post <- @posts} class="font-bold text-md">
            <a href={post.path}>
              <span class="font-normal"><%= post.date %></span> -> <%= post.title %>
            </a>
          </li>
        </ul>
      </div>
    </.layout>
    """
  end

  def post(assigns) do
    ~H"""
    <.layout>
      <%= raw(@post.body) %>
      <%= inspect(@post) %>
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
