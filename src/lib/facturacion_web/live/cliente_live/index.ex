defmodule FacturacionWeb.ClienteLive.Index do
  use FacturacionWeb, :live_view

  alias Facturacion.Clientes
  alias Facturacion.Clientes.Cliente

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :clientes, list_clientes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cliente")
    |> assign(:cliente, Clientes.get_cliente!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cliente")
    |> assign(:cliente, %Cliente{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Clientes")
    |> assign(:cliente, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cliente = Clientes.get_cliente!(id)
    {:ok, _} = Clientes.delete_cliente(cliente)

    {:noreply, assign(socket, :clientes, list_clientes())}
  end

  defp list_clientes do
    Clientes.list_clientes()
  end
end
