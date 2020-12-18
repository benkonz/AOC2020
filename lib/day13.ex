defmodule AOC.Day13 do
  def parse_input(input) do
    [timestamp, departures_str] =
      input
      |> File.read!()
      |> String.split("\n")

    depatures =
      departures_str
      |> String.split(",")
      |> Enum.filter(&(&1 != "x"))
      |> Enum.map(&String.to_integer(&1))

    [timestamp |> String.to_integer(), depatures]
  end

  def solve(timestamp, arrival, departures) do
    found =
      departures
      |> Enum.find_value(fn departure ->
        if rem(timestamp, departure) == 0, do: (timestamp - arrival) * departure, else: nil
      end)

    if found == nil, do: solve(timestamp + 1, arrival, departures), else: found
  end

  def part1(input) do
    [timestamp, departures] = input
    solve(timestamp, timestamp, departures)
  end
end
