defmodule AOC.Day2 do
  def parse_input(filename) do
    File.read(filename)
    |> elem(1)
    |> String.split("\n")
    |> Enum.map(fn line ->
      regex = ~r/^([[:digit:]]+)\-([[:digit:]]+) ([[:ascii:]])\: ([[:word:]]+)$/
      Regex.run(regex, line)
    end)
  end

  def part1(input) do
    input
    |> Enum.reduce(0, fn line, acc ->
      [_str, min, max, char, password] = line
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

  def part2(input) do
    input
    |> Enum.reduce(0, fn line, acc ->
      [_str, min, max, char, password] = line
      pos1 = (Integer.parse(min) |> elem(0)) - 1
      pos2 = (Integer.parse(max) |> elem(0)) - 1

      if (String.at(password, pos1) == char && String.at(password, pos2) != char) ||
           (String.at(password, pos1) != char && String.at(password, pos2) == char) do
        acc + 1
      else
        acc
      end
    end)
  end
end
