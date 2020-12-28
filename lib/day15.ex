defmodule AOC.Day15 do
  def parse_input(input) do
    input
    |> File.read!()
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end

  def part1(input) do
    0 ..2019
    |> Enum.to_list()
    # memory maps the answer to the turns that that answer was used in
    # so [0] -> [4, 1] means that the answer zero was last answered on turn 4 and in turn 1
    |> Enum.reduce({0, %{}}, fn i, {acc, memory} ->
      if i < length(input) do
        answer = Enum.at(input, i)
        memory = Map.put(memory, answer, [i])
        {answer, memory}
      else
        turns = Map.get(memory, acc)

        answer =
          if length(turns) == 1 do
            answer = 0

            answer
          else
            [second, first | _] = turns
            answer = second - first
            answer
          end

        memory =
          memory
          |> Map.get_and_update(answer, fn current_value ->
            new_value = if current_value == nil, do: [i], else: [i | current_value]
            {current_value, new_value}
          end)
          |> elem(1)

        {answer, memory}
      end
    end)
    |> elem(0)
  end
end
