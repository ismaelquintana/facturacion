defmodule FacturacionWeb.PageController do
  use FacturacionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
