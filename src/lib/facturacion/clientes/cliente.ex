defmodule Facturacion.Clientes.Cliente do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clientes" do
    field :cif, :string
    field :direccion, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [:name, :direccion, :cif])
    |> validate_required([:name, :direccion, :cif])
  end
end
