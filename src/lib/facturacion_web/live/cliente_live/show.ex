defmodule FacturacionWeb.ClienteLive.Show do
  use FacturacionWeb, :live_view

  alias Facturacion.Clientes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cliente, Clientes.get_cliente!(id))}
  end

  defp page_title(:show), do: "Show Cliente"
  defp page_title(:edit), do: "Edit Cliente"
end
