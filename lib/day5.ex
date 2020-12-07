defmodule AOC.Day5 do
  def parse_input(input) do
    File.read(input)
    |> elem(1)
    |> String.split("\n")
  end

  def bsp(str, i, low, high) do
    c = String.at(str, i)

    if i == String.length(str) - 1 do
      if c == "B" || c == "R" do
        high
      else
        low
      end
    else
      midpoint = div(low + high, 2)

      if c == "B" || c == "R" do
        bsp(str, i + 1, midpoint + 1, high)
      else
        bsp(str, i + 1, low, midpoint)
      end
    end
  end

  def part1(input) do
    input
    |> Enum.reduce(0, fn seat, acc ->
      row = String.slice(seat, 0..6) |> IO.inspect() |> bsp(0, 0, 127)
      col = String.slice(seat, 7..-1) |> IO.inspect() |> bsp(0, 0, 7)
      IO.inspect({row, col})
      seat_id = row * 8 + col

      if seat_id > acc do
        seat_id
      else
        acc
      end
    end)
  end

  def part2(input) do
  end
end
