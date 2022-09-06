defmodule FacturacionWeb.ClienteLive.Index do
  @moduledoc """
  Module for display of list of clients
  """

  use FacturacionWeb, :live_view

  # import FacturacionWeb.Live.SharedComponents
  import FacturacionWeb.Live.DataTable

  alias Facturacion.Clientes
  alias Facturacion.Clientes.Cliente

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
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

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Clientes")
    |> assign(:params, params)
    |> assign(:clientes, list_clientes(params))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cliente = Clientes.get_cliente!(id)
    {:ok, _} = Clientes.delete_cliente(cliente)

    {:noreply, assign(socket, :clientes, list_clientes(%{}))}
  end

  defp list_clientes(params) do
    Clientes.list_clientes(params)
  end
end
