defmodule AOC.Day3 do
  def parse_input(filename) do
    File.read(filename)
    |> elem(1)
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.graphemes(line)
    end)
  end

  def traverse(board, x, y, dx, dy) do
    col_size = board |> Enum.at(y) |> length
    x_prime = rem(x + dx, col_size)
    y_prime = y + dy

    if y_prime >= length(board) do
      0
    else
      cell = board |> Enum.at(y_prime) |> Enum.at(x_prime)

      if cell == "." do
        traverse(board, x_prime, y_prime, dx, dy)
      else
        1 + traverse(board, x_prime, y_prime, dx, dy)
      end
    end
  end

  def part1(input) do
    traverse(input, 0, 0, 3, 1)
  end
end
