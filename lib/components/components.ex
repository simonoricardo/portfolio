defmodule Website.Components do
  use Phoenix.Component

  attr(:title, :string, required: true)

  def section_title(assigns) do
    ~H"""
    <h2 class="my-4">[<%= @title %>]</h2>
    """
  end

  slot(:inner_block, required: true)

  def paragraph(assigns) do
    ~H"""
    <p class="tracking-tight text-sm xl:text-lg my-2">
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  attr(:to, :string, required: true)
  attr(:new_tab, :boolean, default: false)
  slot(:inner_block, required: true)

  def link(assigns) do
    ~H"""
    <a
      href={@to}
      target={if(@new_tab, do: "_blank", else: nil)}
      class="font-bold inline-block underline"
    >
      <%= render_slot(@inner_block) %>
    </a>
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
      class="bg-white text-zinc-700 py-2 px-4 rounded-md disabled:bg-zinc-300 w-full xl:w-[40rem] hover:cursor-pointer disabled:cursor-not-allowed"
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
      class="bg-white text-zinc-700 py-2 px-4 rounded-md disabled:bg-zinc-300 w-full xl:w-[40rem] hover:cursor-pointer disabled:cursor-not-allowed"
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
    <input
      id={@name}
      name={@name}
      type="text"
      class="py-2 px-4 w-full rounded-sm"
      required={@required}
    />
    """
  end

  defp input(%{type: "email"} = assigns) do
    ~H"""
    <input
      id={@name}
      name={@name}
      type="email"
      class="py-2 px-4 w-full rounded-sm"
      required={@required}
    />
    """
  end

  defp input(%{type: "text_area"} = assigns) do
    ~H"""
    <textarea id={@name} name={@name} class="py-2 px-4 h-72 w-full rounded-sm" required={@required} />
    """
  end

  attr(:name, :string, required: true)
  slot(:inner_block, required: true)

  defp label(assigns) do
    ~H"""
    <label class="w-5/12" for={@name}><%= render_slot(@inner_block) %></label>
    """
  end
end
