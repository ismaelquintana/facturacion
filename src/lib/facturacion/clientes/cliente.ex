defmodule Facturacion.Clientes.Cliente do
  @moduledoc """
  Module with schema for clientes
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "clientes" do
    field :cif, :string
    field :direccion, :string
    field :name, :string

    timestamps()
  end

  @doc """
  Validate data, cif must be or 8 numeric digits and a letter:
  NNNNNNNNC
  or a letter and seven numeric digits:
  CNNNNNNN
  """
  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [:name, :direccion, :cif])
    |> validate_required([:name, :direccion, :cif])
    |> validate_length(:cif, min: 8)
    |> validate_format(
      :cif,
      ~r/^[0-9]{8}[A-Z,a-z]$|^[A-Z,a-z][0-9]{7}$/,
      message: "Formato erroneo."
    )
  end
end
