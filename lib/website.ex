defmodule Website do
  use Phoenix.Component

  alias Website.Blog
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
        <link rel="stylesheet" href="/assets/css/makeup.css" />
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
        <script defer src="https://www.google.com/recaptcha/api.js" async>
        </script>
        <script type="text/javascript" src="/assets/glightbox.js" />
        <script defer type="text/javascript" src="/assets/app.js" />
        <script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/collapse@3.x.x/dist/cdn.min.js">
        </script>
        <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js">
        </script>
      </head>
      <body class="base bg-stone-50 text-zinc-700 font-sans tracking-wide bg-[url('/assets/dot-grid.png')] bg-repeat">
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
      <.posts posts={@posts} />
      <.photos photos={@photos} />
      <.contact_form />
    </.layout>
    """
  end
end
