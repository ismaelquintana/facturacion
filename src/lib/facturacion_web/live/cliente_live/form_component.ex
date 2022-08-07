defmodule FacturacionWeb.ClienteLive.FormComponent do
  @moduledoc """
  Module for live form component to insert new clients
  """
  use FacturacionWeb, :live_component

  alias Facturacion.Clientes

  @impl true
  def update(%{cliente: cliente} = assigns, socket) do
    changeset = Clientes.change_cliente(cliente)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"cliente" => cliente_params}, socket) do
    changeset =
      socket.assigns.cliente
      |> Clientes.change_cliente(cliente_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cliente" => cliente_params}, socket) do
    save_cliente(socket, socket.assigns.action, cliente_params)
  end

  defp save_cliente(socket, :edit, cliente_params) do
    case Clientes.update_cliente(socket.assigns.cliente, cliente_params) do
      {:ok, _cliente} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cliente updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cliente(socket, :new, cliente_params) do
    case Clientes.create_cliente(cliente_params) do
      {:ok, _cliente} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cliente created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
