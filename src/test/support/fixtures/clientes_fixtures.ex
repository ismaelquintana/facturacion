defmodule Facturacion.ClientesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Facturacion.Clientes` context.
  """

  @doc """
  Generate a cliente.
  """
  def cliente_fixture(attrs \\ %{}) do
    {:ok, cliente} =
      attrs
      |> Enum.into(%{
        cif: "02624341H",
        direccion: "some direccion",
        name: "some name"
      })
      |> Facturacion.Clientes.create_cliente()

    cliente
  end
end
