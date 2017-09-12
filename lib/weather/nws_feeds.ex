defmodule NwsFeeds do
  @base_url "http://w1.weather.gov/xml/current_obs/"

  def feed_url(code) do
    "#{@base_url}#{code}.xml"
  end

  def fetch(airport_code) do
    feed_url(airport_code)
    |> HTTPoison.get()
    |> handle_response
    |> build_structure
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    document = Meeseeks.parse(body, :xml)
    {:ok, document}
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    # TODO: Log error
    {:error, body}
  end

  def build_structure({:error, document}) do
    # TODO
  end
  def build_structure({:ok, document}) do
    import Meeseeks.CSS
    # TODO: Exctract getting the value into a function, not working for some
    # reason...
    %{
      location: Meeseeks.one(document, Meeseeks.CSS.css("location"))
      |> Meeseeks.text,
      latitude: Meeseeks.one(document, Meeseeks.CSS.css("latitude"))
      |> Meeseeks.text,
      longitude: Meeseeks.one(document, Meeseeks.CSS.css("longitude"))
      |> Meeseeks.text,
      weather: Meeseeks.one(document, Meeseeks.CSS.css("weather"))
      |> Meeseeks.text,
      temp_c: Meeseeks.one(document, Meeseeks.CSS.css("temp_c"))
      |> Meeseeks.text,
      observation_time: Meeseeks.one(document, Meeseeks.CSS.css("observation_time"))
      |> Meeseeks.text,
      pressure: Meeseeks.one(document, Meeseeks.CSS.css("pressure_string"))
      |> Meeseeks.text,
      visibility: Meeseeks.one(document, Meeseeks.CSS.css("visibility_mi"))
      |> Meeseeks.text,
      wind: Meeseeks.one(document, Meeseeks.CSS.css("wind_string"))
      |> Meeseeks.text,
      wind_mph: Meeseeks.one(document, Meeseeks.CSS.css("wind_mph"))
      |> Meeseeks.text,
      wind_dir: Meeseeks.one(document, Meeseeks.CSS.css("wind_dir"))
      |> Meeseeks.text,
    }
  end

  def parse_value({:error, document}) do
    # TODO: Log and stuff
  end
end
