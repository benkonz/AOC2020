defmodule AOC.Day1 do
  def part1(input) do
    target = 2020

    twoSum(input, target, -1)
  end

  def twoSum(input, target, skip) do
    differences =
      input
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {x, i}, differences ->
        if i != skip do
          Map.put(differences, target - x, i)
        else
          differences
        end
      end)

    input_map =
      input
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {x, i}, input_map ->
        if i != skip do
          Map.put(input_map, x, i)
        else
          input_map
        end
      end)

    differences
    |> Enum.find_value(fn {k, v} ->
      case Map.get(input_map, k) do
        nil ->
          false

        i ->
          if i != v do
            {i, v}
          else
            false
          end
      end
    end)
  end

  def part2(input) do
    target = 2020

    input
    |> Enum.with_index()
    |> Enum.find_value(fn {x, i} ->
      case twoSum(input, target - x, i) do
        nil ->
          false

        {j, k} ->
          if i != j && j != k do
            Enum.at(input, i) * Enum.at(input, j) * Enum.at(input, k)
          else
            false
          end
      end
    end)
  end
end
