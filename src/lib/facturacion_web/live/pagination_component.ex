defmodule FacturacionWeb.Live.PaginationComponent do
  @moduledoc """
  Component for pagination of datatables.
  """
  use FacturacionWeb, :live_component
  import FacturacionWeb.Live.DataTable

  @distance 7

  @doc false
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(pagination_assigns(assigns[:pagination_data]))
    }
  end

  @doc false
  def render(assigns) do
    ~H"""
    <div id={assigns[:id] || "pagination"} class="flex justify-center my-2">
      <%= if @total_pages > 1 do %>
        <div class="btn-group">
          <%= prev_link(@params, @page_number) %>
          <%= for num <- start_page(@page_number)..end_page(@page_number, @total_pages) do %>
            <%= live_patch num, to: "?#{querystring(@params, page: num)}", class: "ml-2 p-1.5 #{if @page_number == num, do: "ml-2 p-1.5 bg-blue-200 rounded-full bg-opacity-100 hover:text-white hover:bg-blue-500", else: "hover:font-bold"}" %>
          <% end %>
          <%= next_link(@params, @page_number, @total_pages) %>
        </div>
      <% end %>
    </div>
    """
  end

  defp pagination_assigns(%Scrivener.Page{} = pagination) do
    [
      page_number: pagination.page_number,
      page_size: pagination.page_size,
      total_entries: pagination.total_entries,
      total_pages: pagination.total_pages
    ]
  end

  def prev_link(conn, current_page) do
    if current_page != 1 do
      live_patch("Prev",
        to: "?" <> querystring(conn, page: current_page - 1),
        class: "btn btn-link"
      )
    else
      live_patch("Prev", to: "#", class: "btn btn-link btn-disabled")
    end
  end

  def next_link(conn, current_page, num_pages) do
    if current_page != num_pages do
      live_patch("Next",
        to: "?" <> querystring(conn, page: current_page + 1),
        class: "btn btn-link"
      )
    else
      live_patch("Next", to: "#", class: "btn btn-link btn-disabled")
    end
  end

  def start_page(current_page) when current_page - @distance <= 0, do: 1
  def start_page(current_page), do: current_page - @distance

  def end_page(current_page, 0), do: current_page

  def end_page(current_page, total)
      when current_page <= @distance and @distance * 2 <= total do
    @distance * 2
  end

  def end_page(current_page, total) when current_page + @distance >= total do
    total
  end

  def end_page(current_page, _total), do: current_page + @distance - 1
end
