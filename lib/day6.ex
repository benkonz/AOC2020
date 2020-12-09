defmodule AOC.Day6 do
  def parse_input(input) do
    input
    |> File.read!()
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
    |> Enum.reduce(0, fn group, acc ->
      answers =
        group
        |> String.split("\n")
        |> Enum.map(&String.graphemes(&1))

      num_people = answers |> length()

      answers_count =
        answers
        |> List.flatten()
        |> Enum.reduce(Map.new(), fn answer, acc ->
          Map.get_and_update(acc, answer, fn i ->
            if i == nil do
              {i, 1}
            else
              {i, i + 1}
            end
          end)
          |> elem(1)
        end)

      num_answers =
        answers_count
        |> Enum.reduce(0, fn {_k, v}, acc ->
          if v == num_people do
            acc + 1
          else
            acc
          end
        end)

      num_answers + acc
    end)
  end
end
