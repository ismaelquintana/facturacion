defmodule Facturacion.Repo.Migrations.CreateClientes do
  use Ecto.Migration

  def change do
    create table(:clientes) do
      add :name, :string
      add :direccion, :string
      add :cif, :string

      timestamps()
    end
  end
end
