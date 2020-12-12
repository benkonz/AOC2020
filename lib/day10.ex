defmodule AOC.Day10 do
  def parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
  end

  def part1(input) do
    {one_jolt_diffs, three_jolt_diffs, _prev_jolts} =
      input
      |> Enum.sort()
      |> Enum.reduce({0, 0, 0}, fn jolts, {one_jolt_diffs, three_jolt_diffs, prev_jolts} ->
        jolt_diff = jolts - prev_jolts

        case jolt_diff do
          3 -> {one_jolt_diffs, three_jolt_diffs + 1, jolts}
          1 -> {one_jolt_diffs + 1, three_jolt_diffs, jolts}
          _ -> {one_jolt_diffs, three_jolt_diffs, jolts}
        end
      end)

    three_jolt_diffs = three_jolt_diffs + 1
    one_jolt_diffs * three_jolt_diffs
  end

  def count(voltage, adapters, mem) do
    if voltage == 0 do
      {1, mem}
    else
      if MapSet.member?(adapters, voltage) do
        if Map.has_key?(mem, voltage) do
          {Map.get(mem, voltage), mem}
        else
          {first, mem} = count(voltage - 1, adapters, mem)
          {second, mem} = count(voltage - 2, adapters, mem)
          {third, mem} = count(voltage - 3, adapters, mem)
          answer = first + second + third
          mem = Map.put(mem, voltage, answer)
          {answer, mem}
        end
      else
        {0, mem}
      end
    end
  end

  def part2(input) do
    adapters = MapSet.new(input)
    biggest = input |> Enum.sort() |> List.last()
    adapters = MapSet.put(adapters, biggest + 3)
    count(biggest + 3, adapters, Map.new()) |> elem(0)
  end
end
