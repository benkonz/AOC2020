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
        slice = Enum.slice(input, (i - window_size)..(i - 1))
        result = AOC.Day1.twoSum(slice, n, -1)
        if result == nil, do: n, else: nil
      end
    end)
  end

  def find_sum(arr, target, curr_sum, i, j) do
    if j <= length(arr) do
      if curr_sum == target do
        [i, j - 1]
      else
        if curr_sum > target || j == length(arr) do
          nil
        else
          find_sum(arr, target, curr_sum + Enum.at(arr, j), i, j + 1)
        end
      end
    end
  end

  def subarray_sum(arr, target) do
    arr
    |> Enum.with_index()
    |> Enum.find_value(fn {n, i} ->
      find_sum(arr, target, n, i, i + 1)
    end)
  end

  def part2(input, target) do
    [start_index, finish_index] = subarray_sum(input, target)
    sorted = input |> Enum.slice(start_index..finish_index) |> Enum.sort()
    List.first(sorted) + List.last(sorted)
  end
end
