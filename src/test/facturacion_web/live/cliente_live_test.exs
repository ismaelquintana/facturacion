defmodule FacturacionWeb.ClienteLiveTest do
  use FacturacionWeb.ConnCase

  import Phoenix.LiveViewTest
  import Facturacion.ClientesFixtures

  @create_attrs %{cif: "02624341H", direccion: "some direccion", name: "some name"}
  @update_attrs %{
    cif: "83746576Y",
    direccion: "some updated direccion",
    name: "some updated name"
  }
  @invalid_attrs %{cif: nil, direccion: nil, name: nil}

  defp create_cliente(_) do
    cliente = cliente_fixture()
    %{cliente: cliente}
  end

  describe "Index" do
    setup [:create_cliente]

    test "lists all clientes", %{conn: conn, cliente: cliente} do
      {:ok, _index_live, html} = live(conn, Routes.cliente_index_path(conn, :index))

      assert html =~ "Listing Clientes"
      assert html =~ cliente.cif
    end

    test "saves new cliente", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.cliente_index_path(conn, :index))

      assert index_live |> element("a", "New Cliente") |> render_click() =~
               "New Cliente"

      assert_patch(index_live, Routes.cliente_index_path(conn, :new))

      assert index_live
             |> form("#cliente-form", cliente: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cliente-form", cliente: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cliente_index_path(conn, :index))

      assert html =~ "Cliente created successfully"
      assert html =~ "02624341H"
    end

    test "updates cliente in listing", %{conn: conn, cliente: cliente} do
      {:ok, index_live, _html} = live(conn, Routes.cliente_index_path(conn, :index))

      assert index_live |> element("#cliente-#{cliente.id} a", "Edit") |> render_click() =~
               "Edit Cliente"

      assert_patch(index_live, Routes.cliente_index_path(conn, :edit, cliente))

      assert index_live
             |> form("#cliente-form", cliente: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cliente-form", cliente: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cliente_index_path(conn, :index))

      assert html =~ "Cliente updated successfully"
      assert html =~ "83746576Y"
    end

    test "deletes cliente in listing", %{conn: conn, cliente: cliente} do
      {:ok, index_live, _html} = live(conn, Routes.cliente_index_path(conn, :index))

      assert index_live |> element("#cliente-#{cliente.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cliente-#{cliente.id}")
    end
  end

  describe "Show" do
    setup [:create_cliente]

    test "displays cliente", %{conn: conn, cliente: cliente} do
      {:ok, _show_live, html} = live(conn, Routes.cliente_show_path(conn, :show, cliente))

      assert html =~ "Show Cliente"
      assert html =~ cliente.cif
    end

    test "updates cliente within modal", %{conn: conn, cliente: cliente} do
      {:ok, show_live, _html} = live(conn, Routes.cliente_show_path(conn, :show, cliente))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cliente"

      assert_patch(show_live, Routes.cliente_show_path(conn, :edit, cliente))

      assert show_live
             |> form("#cliente-form", cliente: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cliente-form", cliente: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cliente_show_path(conn, :show, cliente))

      assert html =~ "Cliente updated successfully"
      assert html =~ "83746576Y"
    end
  end
end
