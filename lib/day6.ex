defmodule AOC.Day6 do
  def parse_input(input) do
    input
    |> File.read()
    |> elem(1)
    |> String.split("\n\n")
  end

  def part1(input) do
    input
    |> Enum.reduce(0, fn group, acc ->
      answers =
        group
        |> String.split("\n")
        |> Enum.map(&String.graphemes(&1))
        |> List.flatten()
        |> Enum.reduce(MapSet.new(), fn answer, answers ->
          MapSet.put(answers, answer)
        end)

      acc + MapSet.size(answers)
    end)
  end

  def part2(input) do
    input
  end
end
