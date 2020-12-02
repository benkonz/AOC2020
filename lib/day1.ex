defmodule AOC.Day1 do
  def solution(input) do
    target = 2020
    differences = input
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({x, i}, differences) ->
      Map.put(differences, target - x, i)
    end)

    input_map = input
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({x, i}, input_map) ->
      Map.put(input_map, x, i)
    end)

    differences
    |> Enum.find_value(fn({k, v}) ->
      case Map.get(input_map, k) do
        nil -> false
        i -> if i != v do k * (2020 - k) else false end
      end
    end)

  end
end
