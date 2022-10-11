defmodule FacturacionWeb.Live.DataTable do
  @moduledoc """
  Sort list of table
  """
  # import Phoenix.LiveView.Helpers
  alias Plug.Conn.Query

  @doc """
  Convert direction of sort from string to atom when value is asc, desc
  if no value is provide :asc is set
  """
  def sort(%{"sort_field" => field, "sort_direction" => direction})
      when direction in ~w(asc desc) do
    {String.to_atom(direction), String.to_existing_atom(field)}
  end

  def sort(_other) do
    {:asc, :id}
  end

  @doc """
  Helper function for setting correct live_patch in templates
  with the params for sort_direction and sort_field
  """
  def table_link(params, field) do
    direction = params["sort_direction"]

    opts =
      if params["sort_field"] == to_string(field) do
        [
          sort_field: field,
          sort_direction: reverse(direction)
        ]
      else
        [
          sort_field: field,
          sort_direction: "desc"
        ]
      end

    # live_patch(text, to: "?" <> querystring(params, opts), class: "link flex items-center")
    "?" <> querystring(params, opts)
  end

  def column_icon(params, field) do
    if params["sort_field"] == to_string(field) do
      if params["sort_direction"] == "asc" do
        "<Boxicons.up_arrow solid class='w-4 h-4 mr-1'/>"
      else
        "<Boxicons.down_arrow solid class='w-4 h-4 mr-1'/>"
      end
    else
      "<Boxicons.sort_alt class='w-4 h-4 mr-1'/>"
    end
  end

  def querystring(params, opts) do
    params = params |> Query.encode() |> URI.decode_query()

    opts = %{
      "page" => opts[:page],
      "sort_field" => opts[:sort_field] || params["sort_field"] || nil,
      "sort_direction" => opts[:sort_direction] || params["sort_direction"] || nil
    }

    params
    |> Map.merge(opts)
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
    |> URI.encode_query()
  end

  defp reverse("desc"), do: "asc"
  defp reverse(_), do: "desc"
end
