defmodule AOC.Day2 do
  def parse_input(filename) do
    File.read(filename) |> elem(1) |> String.split("\n")
  end

  def part1(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(0, fn {line, i}, acc ->
      regex = ~r/^([[:digit:]]+)\-([[:digit:]]+) ([[:ascii:]])\: ([[:word:]]+)$/
      [_str, min, max, char, password] = Regex.run(regex, line)
      min = Integer.parse(min) |> elem(0)
      max = Integer.parse(max) |> elem(0)

      count =
        password
        |> String.graphemes()
        |> Enum.reduce(0, fn c, count ->
          if char == c do
            count + 1
          else
            count
          end
        end)

      if count < min || count > max do
        acc
      else
        acc + 1
      end
    end)
  end
end
