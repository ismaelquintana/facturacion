defmodule FacturacionWeb.Live.SharedComponents do
  @moduledoc """
  component to show dropdown when exporting data to excel, not in use yet
  """
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @doc false
  def dropdown(assigns) do
    # ~H"""
    # <div class="relative inline-block text-left">
    #   <button
    #     class="p-1.5 text-xs uppercase tracking-wider
    #           text-indigo-900 bg-indigo-200 rounded-lg bg-opacity-100 hover:font-bold"
    #     phx-click=
    #       { JS.toggle(to: "##{@id}",
    #          in: {"duration-300", "opacity-0", "opacity-100"},
    #         out: {"duration-75", "opacity-100", "opacity-0"})}
    #   >
    #     <%= render_slot(@toggle) %>
    #   </button>
    #   <div id={@id} class="absolute right-0 z-20 hidden"
    #     phx-click-away={JS.hide(to: "##{@id}", transition: {"duration-75", "opacity-100", "opacity-0"})}
    #   >
    #     <%= render_slot(@inner_block, assigns) %>
    #   </div>
    # </div>
    # """
    ~H"""
    <div class="relative inline-block text-left">
      <button class="btn btn-secondary" phx-click={ JS.toggle(to: "##{@id}", in: {"duration-300", "opacity-0", "opacity-100"}, out: {"duration-75", "opacity-100", "opacity-0"})  } >
        <%= render_slot(@toggle) %>
      </button>
      <div id={@id} class="absolute right-0 z-20 hidden" phx-click-away={JS.hide(to: "##{@id}", transition: {"duration-75", "opacity-100", "opacity-0"})}>
        <%= render_slot(@inner_block, assigns) %>
      </div>
    </div>
    """
  end
end
