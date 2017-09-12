defmodule WeatherWeb.AirportController do
  use WeatherWeb, :controller

  alias Weather.Airports
  alias Weather.Airports.Airport

  def index(conn, _params) do
    airports = Airports.list_airports()
    render(conn, "index.html", airports: airports)
  end

  def new(conn, _params) do
    changeset = Airports.change_airport(%Airport{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"airport" => airport_params}) do
    case Airports.create_airport(airport_params) do
      {:ok, airport} ->
        conn
        |> put_flash(:info, "Airport created successfully.")
        |> redirect(to: airport_path(conn, :show, airport))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    airport = Airports.get_airport!(id)
    id = String.upcase("K" <> airport.code)
    data = NwsFeeds.fetch(id)
    render(conn, "show.html", airport: airport, data: data)
  end

  def edit(conn, %{"id" => id}) do
    airport = Airports.get_airport!(id)
    changeset = Airports.change_airport(airport)
    render(conn, "edit.html", airport: airport, changeset: changeset)
  end

  def update(conn, %{"id" => id, "airport" => airport_params}) do
    airport = Airports.get_airport!(id)

    case Airports.update_airport(airport, airport_params) do
      {:ok, airport} ->
        conn
        |> put_flash(:info, "Airport updated successfully.")
        |> redirect(to: airport_path(conn, :show, airport))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", airport: airport, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    airport = Airports.get_airport!(id)
    {:ok, _airport} = Airports.delete_airport(airport)

    conn
    |> put_flash(:info, "Airport deleted successfully.")
    |> redirect(to: airport_path(conn, :index))
  end
end
