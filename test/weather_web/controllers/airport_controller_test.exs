defmodule WeatherWeb.AirportControllerTest do
  use WeatherWeb.ConnCase

  alias Weather.Airports

  @create_attrs %{code: "some code", name: "some name"}
  @update_attrs %{code: "some updated code", name: "some updated name"}
  @invalid_attrs %{code: nil, name: nil}

  def fixture(:airport) do
    {:ok, airport} = Airports.create_airport(@create_attrs)
    airport
  end

  describe "index" do
    test "lists all airports", %{conn: conn} do
      conn = get conn, airport_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Airports"
    end
  end

  describe "new airport" do
    test "renders form", %{conn: conn} do
      conn = get conn, airport_path(conn, :new)
      assert html_response(conn, 200) =~ "New Airport"
    end
  end

  describe "create airport" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, airport_path(conn, :create), airport: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == airport_path(conn, :show, id)

      conn = get conn, airport_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Airport"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, airport_path(conn, :create), airport: @invalid_attrs
      assert html_response(conn, 200) =~ "New Airport"
    end
  end

  describe "edit airport" do
    setup [:create_airport]

    test "renders form for editing chosen airport", %{conn: conn, airport: airport} do
      conn = get conn, airport_path(conn, :edit, airport)
      assert html_response(conn, 200) =~ "Edit Airport"
    end
  end

  describe "update airport" do
    setup [:create_airport]

    test "redirects when data is valid", %{conn: conn, airport: airport} do
      conn = put conn, airport_path(conn, :update, airport), airport: @update_attrs
      assert redirected_to(conn) == airport_path(conn, :show, airport)

      conn = get conn, airport_path(conn, :show, airport)
      assert html_response(conn, 200) =~ "some updated code"
    end

    test "renders errors when data is invalid", %{conn: conn, airport: airport} do
      conn = put conn, airport_path(conn, :update, airport), airport: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Airport"
    end
  end

  describe "delete airport" do
    setup [:create_airport]

    test "deletes chosen airport", %{conn: conn, airport: airport} do
      conn = delete conn, airport_path(conn, :delete, airport)
      assert redirected_to(conn) == airport_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, airport_path(conn, :show, airport)
      end
    end
  end

  defp create_airport(_) do
    airport = fixture(:airport)
    {:ok, airport: airport}
  end
end
