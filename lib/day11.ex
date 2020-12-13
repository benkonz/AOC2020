defmodule AOC.Day11 do
  def parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.graphemes(&1))
  end

  def within_bounds(board, i, j) do
    board |> length() > j && board |> Enum.at(j) |> length() > i && i >= 0 && j >= 0
  end

  def generate_new_cell(board, i, j) do
    cell = board |> Enum.at(j) |> Enum.at(i)
    l = if within_bounds(board, i, j - 1), do: board |> Enum.at(j - 1) |> Enum.at(i), else: nil
    r = if within_bounds(board, i, j + 1), do: board |> Enum.at(j + 1) |> Enum.at(i), else: nil
    u = if within_bounds(board, i - 1, j), do: board |> Enum.at(j) |> Enum.at(i - 1), else: nil
    d = if within_bounds(board, i + 1, j), do: board |> Enum.at(j) |> Enum.at(i + 1), else: nil

    lu =
      if within_bounds(board, i + 1, j + 1),
        do: board |> Enum.at(j + 1) |> Enum.at(i + 1),
        else: nil

    ld =
      if within_bounds(board, i + 1, j - 1),
        do: board |> Enum.at(j - 1) |> Enum.at(i + 1),
        else: nil

    ru =
      if within_bounds(board, i - 1, j + 1),
        do: board |> Enum.at(j + 1) |> Enum.at(i - 1),
        else: nil

    rd =
      if within_bounds(board, i - 1, j - 1),
        do: board |> Enum.at(j - 1) |> Enum.at(i - 1),
        else: nil

    cells = [l, r, u, d, lu, ld, ru, rd]

    sum =
      cells
      |> Enum.reduce(0, fn cell, sum ->
        if cell == "#", do: sum + 1, else: sum
      end)

    case cell do
      "#" ->
        if sum >= 4, do: "L", else: "#"

      "L" ->
        if sum == 0, do: "#", else: "L"

      "." ->
        "."
    end
  end

  def solve(board) do
    old_board = Enum.to_list(board)

    board =
      board
      |> Enum.with_index()
      |> Enum.map(fn {row, j} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {_cell, i} ->
          generate_new_cell(old_board, i, j)
        end)
      end)

    if old_board != board, do: solve(board), else: board
  end

  def part1(input) do
    final_board = solve(input)

    final_board
    |> Enum.reduce(0, fn row, sum ->
      row
      |> Enum.reduce(sum, fn cell, sum ->
        if cell == "#", do: sum + 1, else: sum
      end)
    end)
  end
end
