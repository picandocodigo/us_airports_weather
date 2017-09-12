defmodule WeatherWeb.AirportController do
  use WeatherWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, params) do
    id = String.upcase("K" <> params["id"])
    import NwsFeeds
    data = NwsFeeds.fetch(id)
    render conn, "show.html", id: id, data: data
  end
end
