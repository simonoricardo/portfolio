defmodule Website.Components do
  use Phoenix.Component
  import Phoenix.HTML

  attr(:id, :string, required: true)
  attr(:active, :boolean, default: false)
  slot(:inner_block, required: true)

  def nav_element(assigns) do
    ~H"""
    <li
      id={@id}
      class={[
        "px-1 hover:bg-zinc-700 hover:text-stone-50 hover:rounded-md hover:rotate-6 hover:scale-110 transition-all",
        @active && "bg-zinc-700 text-stone-50 rounded-md rotate-6 scale-110"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </li>
    """
  end

  attr(:post, :map, required: true)

  def post(assigns) do
    ~H"""
    <Website.layout active={:posts}>
      <a href="/#posts" class="underline mb-0 text-sm text-zinc-600">
        <%= "Go back" %>
      </a>
      <div class="prose container max-w-none max-w-screen-sm lg:max-w-screen-lg xl:max-w-screen-xl mx-auto my-8 py-4 px-4 lg:px-16 xl:px-32 rounded-lg bg-stone-50 border">
        <p class="text-md font-bold italic my-0 mt-2"><%= @post.author %></p>
        <p class="text-sm italic my-0 mb-4"><%= @post.date %></p>
        <hr />
        <%= raw(@post.body) %>
      </div>
    </Website.layout>
    """
  end

  attr(:title, :string, required: true)

  def section_title(assigns) do
    ~H"""
    <h2 class="inline-block mb-8 bg-zinc-700 text-stone-50 px-2 -rotate-3 rounded-md">
      <%= @title %>
    </h2>
    """
  end

  attr(:class, :string, default: "")
  slot(:inner_block, required: true)

  def paragraph(assigns) do
    ~H"""
    <p class={["tracking-wide text-lg xl:text-xl my-4", @class]}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  attr(:to, :string, required: true)
  attr(:new_tab, :boolean, default: false)
  attr(:highlight, :boolean, default: false)
  slot(:inner_block, required: true)

  def link(assigns) do
    ~H"""
    <a
      href={@to}
      target={if(@new_tab, do: "_blank", else: nil)}
      class={[
        "font-bold inline-block underline",
        @highlight && "bg-zinc-700 text-stone-50 px-1 rounded-md decoration-stone-50"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </a>
    """
  end

  slot(:inner_block, required: true)

  def highlight(assigns) do
    ~H"""
    <span class="font-bold bg-zinc-700 text-stone-50 px-1 rounded-md inline-block">
      <%= render_slot(@inner_block) %>
    </span>
    """
  end

  attr(:name, :string)
  attr(:type, :string, required: true)
  attr(:disabled, :boolean, default: false)
  slot(:inner_block, required: true)

  def button(%{type: "submit"} = assigns) do
    ~H"""
    <button
      id="submit"
      name={@name}
      type="submit"
      class="bg-stone-100 border text-zinc-700 py-2 px-4 rounded-md disabled:bg-zinc-300 w-full xl:w-[40rem] hover:cursor-pointer disabled:cursor-not-allowed"
      disabled={@disabled}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  def button(%{type: "button"} = assigns) do
    ~H"""
    <button
      id={@name}
      type="button"
      class="bg-stone-100 border text-zinc-700 py-2 px-4 rounded-md disabled:bg-zinc-300 w-full xl:w-[40rem] hover:cursor-pointer disabled:cursor-not-allowed"
      disabled={@disabled}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  attr(:name, :string, required: true)
  attr(:rest, :global, include: ~w(type required))
  slot(:inner_block, required: true)

  def field(assigns) do
    ~H"""
    <div class="flex w-full xl:w-[40rem] justify-between items-center">
      <.label name={@name}><%= render_slot(@inner_block) %></.label>
      <.input id={@name} name={@name} {@rest} />
    </div>
    """
  end

  attr(:id, :string, required: true)
  attr(:name, :string, required: true)
  attr(:required, :boolean, default: false)
  attr(:type, :string, required: true)

  defp input(%{type: "text"} = assigns) do
    ~H"""
    <input id={@name} name={@name} type="text" class={input_classes()} required={@required} />
    """
  end

  defp input(%{type: "email"} = assigns) do
    ~H"""
    <input id={@name} name={@name} type="email" class={input_classes()} required={@required} />
    """
  end

  defp input(%{type: "text_area"} = assigns) do
    ~H"""
    <textarea id={@name} name={@name} class={[input_classes(), "h-72"]} required={@required} />
    """
  end

  attr(:name, :string, required: true)
  slot(:inner_block, required: true)

  defp label(assigns) do
    ~H"""
    <label class="w-5/12" for={@name}><%= render_slot(@inner_block) %></label>
    """
  end

  defp input_classes, do: ~w(py-2 px-4 w-full rounded-sm border)

  slot(:inner_block, required: true)

  def text_background(assigns) do
    ~H"""
    <p class="hidden font-bold font-serif inline-block text-stone-50 text-[12rem] [text-shadow:0_0_1px_#a1a1aa,_0_0_1px_#a1a1aa,_0_0_1px_#a1a1aa,_0_0_1px_#a1a1aa] absolute z-[-1] bottom-24 right-8 lg:visible">
      <%= render_slot(@inner_block) %>
    </p>
    """
  end
end
