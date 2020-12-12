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
end
