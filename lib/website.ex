defmodule Website do
  use Phoenix.Component
  import Phoenix.HTML

  alias Website.Blog
  alias Website.Photo

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
      <div class="my-48">
        <p class="text-3xl xl:text-5xl font-bold my-8">Hello!</p>
        <p class="xl:text-xl">
          I am a full stack developer, with a passion for bringing people's ideas to life.
        </p>
        <p class="xl:text-xl">
          I currently work mostly with <span class="font-bold">Elixir</span>, <span class="font-bold">React</span>,
          <span class="font-bold">React Native</span>
          and <span class="font-bold">Typescript</span>.
        </p>
        <p class="mt-4 xl:text-xl">
          I am Canadian, bilingual, have a passion for
          <a href="#" class="font-bold underline">photography</a>
          and previously worked as a <a
            href="https://www.jobbank.gc.ca/marketreport/summary-occupation/22706/ca"
            target="_blank"
            class="font-bold underline"
          >flight dispatcher</a>.
        </p>
      </div>

      <div class="mb-8 scroll-my-40" id="about">
        <h2 class="my-4">[about me]</h2>
        <p class="tracking-tight text-sm xl:text-lg my-2">
          It all began a few years ago, when I was working as a <a
            href="https://www.jobbank.gc.ca/marketreport/summary-occupation/22706/ca"
            target="_blank"
            class="font-bold underline"
          >flight dispatcher</a>.
          Having worked for various Canadian airlines, I recognized the significant impact that the right tools can have on job effectiveness.
          When COVID-19 hit, I decided to switch careers and pursue software development to help businesses and individuals streamline
          processes and enhance efficiency.
        </p>
        <p class="tracking-tight text-sm xl:text-lg my-2">
          I have since accumulated a few years of experience in software development and aim to continue working on projects that have a positive impact on the world.
        </p>
        <p class="tracking-tight xl:text-xl my-6">
          >> Here is my resume <a href="cv-fr.pdf" target="_blank" class="font-bold underline">FR</a>
          / EN
        </p>
        <p class="tracking-tight text-sm xl:text-lg my-2">
          If you wish to contact me, you may do so <a href="#" class="font-bold underline">here</a>,
        </p>
      </div>
      <div class="mb-8 my-16 scroll-my-40" id="posts">
        <h2 class="my-4">[posts]</h2>
        <ul>
          Coming soon!
        </ul>
      </div>
      <div class="mb-8 my-16 xl:text-xl scroll-my-40" id="photos">
        <h2 class="my-4">[photos]</h2>
        <p class="tracking-tight text-sm xl:text-lg my-2">
          I have been passionate about photography since childhood. I cherish the ability to capture timeless moments and present them as I truly remember them.
          It's often said that a picture is worth a thousand words, and a single image can convey so many emotions.
        </p>
        <p class="tracking-tight text-sm xl:text-lg my-2">
          I started my journey with a Nikon D3000 and then upgraded to a Nikon D300. Eventually, I transitioned to the Fuji system.
          Currently, I own a Fuji X100V and a Fuji XT-10, equipped with a 90mm prime lens, a 55-230mm zoom lens, and the 16-50mm kit lens.
        </p>
        <p class="tracking-tight text-sm xl:text-lg my-2">
          There's something unique about Fuji cameras. The way they render JPEGs, the film simulations, and the compact size of their mirrorless models all contribute to the joy of shooting with them.
        </p>
        <div class="grid grid-cols-auto-fit-300 xl:grid-cols-auto-fit-400 auto-rows-min gap-4 mt-8">
          <%= for %{photo: photo, thumbnail: thumbnail} <- Photo.all_photos() do %>
            <a href={photo} class="glightbox" data-type="image" data-effect="fade">
              <img
                src={thumbnail}
                class="object-cover w-full h-72 lg:h-96 xl:h-[32rem] border rounded-md"
              />
            </a>
          <% end %>
        </div>
      </div>
      <form
        id="contact-form"
        class="flex flex-col items-start gap-4 mb-8 my-16 xl:text-xl scroll-my-40"
      >
        <h2 class="my-4">[contact me]</h2>
        <div class="flex w-full xl:w-[40rem] justify-between items-center">
          <label class="w-5/12" for="user_name">Name</label>
          <input
            id="user_name"
            type="text"
            name="user_name"
            class="py-2 px-4 w-full rounded-sm"
            required
          />
        </div>
        <div class="flex w-full xl:w-[40rem] justify-between items-center">
          <label class="w-5/12" for="user_email">Email</label>
          <input
            id="user_email"
            type="email"
            name="user_email"
            class="py-2 px-4 w-full rounded-sm"
            required
          />
        </div>
        <div class="flex w-full xl:w-[40rem] justify-between items-center">
          <label class="w-5/12">Message</label>
          <textarea name="message" class="py-2 px-4 h-72 w-full rounded-sm" required></textarea>
        </div>
        <input
          id="submit"
          name="submitButton"
          type="submit"
          value="⚡ Send"
          class="bg-white text-zinc-700 py-2 px-4 rounded-md disabled:bg-zinc-300 w-full xl:w-[40rem] hover:cursor-pointer"
        />
        <button
          type="button"
          id="reset_button"
          class="bg-white text-zinc-700 py-2 px-4 rounded-md disabled:bg-zinc-300 w-full xl:w-[40rem] hover:cursor-pointer"
        >
          🗑️ Reset
        </button>
        <div class="g-recaptcha" data-sitekey="6LfEWOYpAAAAAMfsgENxMDhAGI3MO9LAs9niHKb-"></div>
      </form>
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
