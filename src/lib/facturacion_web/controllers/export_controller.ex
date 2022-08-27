defmodule FacturacionWeb.ExportController do
  @moduledoc """
  Export excel para clientes
  """
  use FacturacionWeb, :controller

  alias Facturacion.Clientes

  # def create(conn, %{"export_field" => export_fields} = params) do

  @doc """
  create de excel, with name and type content
  """
  def create(conn, _params) do
    fields = [:name, :direccion, :cif]
    # Enum.reduce(export_fields, [], fn {field, active}, acc ->
    #   field = String.to_existing_atom(field)
    #   if active == "true", do: [field|acc], else: acc
    # end)
    csv_data =
      Clientes.list_clientes()
      |> csv_content(fields)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"export.csv\"")
    |> put_root_layout(false)
    |> send_resp(200, csv_data)
  end

  @doc """
  convert data to csv
  """
  def csv_content(records, fields) do
    records
    |> Enum.map(fn record ->
      record
      |> Map.from_struct()
      |> Map.take([])
      |> Map.merge(Map.take(record, fields))
      |> Map.values()
    end)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
