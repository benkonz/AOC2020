defmodule AOC.Day13 do
  def parse_input(input) do
    [timestamp, departures_str] =
      input
      |> File.read!()
      |> String.split("\n")

    depatures =
      departures_str
      |> String.split(",")
      |> Enum.map(&if &1 != "x", do: String.to_integer(&1), else: nil)

    [timestamp |> String.to_integer(), depatures]
  end

  def solve_part1(timestamp, arrival, departures) do
    found =
      departures
      |> Enum.filter(&(&1 != nil))
      |> Enum.find_value(fn departure ->
        if rem(timestamp, departure) == 0, do: (timestamp - arrival) * departure, else: nil
      end)

    if found == nil, do: solve_part1(timestamp + 1, arrival, departures), else: found
  end

  def part1(input) do
    [timestamp, departures] = input
    solve_part1(timestamp, timestamp, departures)
  end

  def rec({timing, offset}, lcm, timestamp) do
    if rem(timestamp + offset, timing) != 0 do
      rec({timing, offset}, lcm, timestamp + lcm)
    else
      {lcm * timing, timestamp}
    end
  end

  def solve_part2(departures) do
    departures
    |> Enum.reduce({1, 0}, fn departure, {lcm, timestamp} ->
      rec(departure, lcm, timestamp)
    end)
    |> elem(1)
  end

  def part2(input) do
    [_, departures] = input

    departures =
      departures
      |> Enum.with_index()
      |> Enum.filter(fn {departure, _i} -> departure != nil end)

    solve_part2(departures)
  end
end
