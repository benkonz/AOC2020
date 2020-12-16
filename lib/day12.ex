defmodule AOC.Day12 do
  def parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      direction = String.slice(line, 0..0)
      mag = String.slice(line, 1..-1) |> String.to_integer()
      [direction, mag]
    end)
  end

  def part1(input) do
    [ew, ns, _heading] =
      input
      |> Enum.reduce([0, 0, 0], fn [dir, mag], [ew, ns, heading] ->
        IO.inspect([ew, ns, heading])

        case dir do
          "N" ->
            [ew, ns + mag, heading]

          "S" ->
            [ew, ns - mag, heading]

          "E" ->
            [ew + mag, ns, heading]

          "W" ->
            [ew - mag, ns, heading]

          "L" ->
            [ew, ns, rem(heading + mag, 360)]

          "R" ->
            [ew, ns, rem(heading + 360 - mag, 360)]

          "F" ->
            [ew, ns] =
              case heading do
                0 -> [ew + mag, ns]
                90 -> [ew, ns + mag]
                180 -> [ew - mag, ns]
                270 -> [ew, ns - mag]
              end

            [ew, ns, heading]
        end
      end)

    abs(ew) + abs(ns)
  end

  def part2(input) do
  end
end
