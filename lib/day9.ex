defmodule AOC.Day9 do
  def parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
  end

  def part1(input, window_size) do
    input
    |> Enum.with_index()
    |> Enum.find_value(fn {n, i} ->
      if i >= window_size do
        (i - window_size)..(i - 1) |> Enum.to_list()
        slice = Enum.slice(input, (i - window_size)..(i - 1))
        result = AOC.Day1.twoSum(slice, n, -1)
        if result == nil, do: n, else: nil
      end
    end)
  end
end
