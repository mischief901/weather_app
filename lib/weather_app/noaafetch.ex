defmodule WeatherApp.NOAAFetch do

  def fetch(location) do
    xml_url(location) # creates url of the xmllocation
    |> HTTPoison.get # gets xml response from NOAA
    |> handle_response # sends xml response to appropriate function/error.
  end

  def xml_url(location) do
    "http://w1.weather.gov/xml/current_obs/#{location}.xml"
  end

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, body }
  end

  def handle_response({ _, %{status_code: _, body: body}}) do
    { :error, body }
  end

end