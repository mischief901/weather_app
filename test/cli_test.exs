defmodule CliTest do
  use ExUnit.Case
  doctest WeatherApp

  import WeatherApp.CLI, only: [ parse_args: 1 ]

  test ":help returned when parsing -h and --help options." do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "given a location, a location is returned" do
    assert parse_args(["KBOS"]) == { "KBOS" }
  end

  test "given no location, the default location is returned." do
    assert parse_args([]) == { "KBOS" }
  end
end
