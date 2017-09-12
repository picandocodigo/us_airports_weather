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
    document = Floki.parse(body)
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
    text = fn(key) -> document |> Floki.find(key) |> Floki.text end
    %{
      location: text.("location"),
      latitude: text.("latitude"),
      longitude: text.("longitude"),
      weather: text.("weather"),
      temp_c: text.("temp_c"),
      observation_time: text.("observation_time"),
      pressure: text.("pressure_string"),
      visibility: text.("visibility_mi"),
      wind: text.("wind_string")
    }
  end
end
