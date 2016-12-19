defmodule ParseXML do
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")

  def parse({ :ok , text}) do
    [ parse_location(text) ] ++ # searches for location
    [ parse_temp(text) ] ++  # searches for temperature
    [ parse_weather(text) ] # searches for weather condition
  end

  def parse_location(text) do
    location = parse_xml(text, '/current_observation/location')
  end

  def parse_temp(text) do
    temperature = parse_xml(text, '/current_observation/temperature_string')
  end

  def parse_weather(text) do
    weather = parse_xml(text, '/current_observation/weather')
  end

  defp parse_xml(text, path) do
    { xml, _rest } = :xmerl_scan.string(String.to_charlist(text))
    [ element ] = :xmerl_xpath.string(path, xml)
    [ text ] = xmlElement(element, :content)
    xmlText(text, :value)
  end
end