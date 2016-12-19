defmodule WeatherApp.CLI do

  @default_loc "KBOS"

  @moduledoc """
  Handle the command line parsing and the function dispatch for the local weather.
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
    |> ParseXML.parse
    |> TableFormat.print
  end

  @doc """
  'argv' can be -h or --help for help.

  'argv' can also be the NOAA call letters for a city. The default location is 
  KBOS for Boston, MA.
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases:  [ h:    :help    ])
    case parse do

    { [ help: true ], _, _ }
      -> :help
    { _, [ location ], _ }
      -> { location }
    { _, [], _ }
      -> { @default_loc }
    _ -> :help

    end
  end

  def process(:help) do
    IO.puts """
    usage:  weatherapp [ location | #{@default_loc} ]
    """
    System.halt(0)
  end

  def process({ location }) do
    WeatherApp.NOAAFetch.fetch(location)
  end

end