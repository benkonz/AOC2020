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

  def rotate(w_ew, w_ns, mag) do
    if mag <= 0 do
      [w_ew, w_ns]
    else
      rotate(-w_ns, w_ew, mag - 90)
    end
  end

  def part2(input) do
    [s_ew, s_ns, _w_ew, _w_ns] =
      input
      |> Enum.reduce([0, 0, 10, 1], fn [dir, mag], [s_ew, s_ns, w_ew, w_ns] ->
        case dir do
          "N" ->
            [s_ew, s_ns, w_ew, w_ns + mag]

          "S" ->
            [s_ew, s_ns, w_ew, w_ns - mag]

          "E" ->
            [s_ew, s_ns, w_ew + mag, w_ns]

          "W" ->
            [s_ew, s_ns, w_ew - mag, w_ns]

          "F" ->
            [s_ew + w_ew * mag, s_ns + w_ns * mag, w_ew, w_ns]

          _ ->
            deg = if dir == "L", do: mag, else: 360 - mag
            [w_ew, w_ns] = rotate(w_ew, w_ns, deg)
            [s_ew, s_ns, w_ew, w_ns]
        end
      end)

    abs(s_ew) + abs(s_ns)
  end
end
