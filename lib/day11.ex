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

  def cell_at(board, i, j) do
    board |> Enum.at(j) |> Enum.at(i)
  end

  def generate_new_cell_part1(board, i, j) do
    cell = cell_at(board, i, j)
    l = if within_bounds(board, i, j - 1), do: cell_at(board, i, j - 1), else: nil
    r = if within_bounds(board, i, j + 1), do: cell_at(board, i, j + 1), else: nil
    u = if within_bounds(board, i - 1, j), do: cell_at(board, i - 1, j), else: nil
    d = if within_bounds(board, i + 1, j), do: cell_at(board, i + 1, j), else: nil

    lu =
      if within_bounds(board, i + 1, j + 1),
        do: cell_at(board, i + 1, j + 1),
        else: nil

    ld =
      if within_bounds(board, i + 1, j - 1),
        do: cell_at(board, i + 1, j - 1),
        else: nil

    ru =
      if within_bounds(board, i - 1, j + 1),
        do: cell_at(board, i - 1, j + 1),
        else: nil

    rd =
      if within_bounds(board, i - 1, j - 1),
        do: cell_at(board, i - 1, j - 1),
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

  def solve_part1(board) do
    old_board = Enum.to_list(board)

    board =
      board
      |> Enum.with_index()
      |> Enum.map(fn {row, j} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {_cell, i} ->
          generate_new_cell_part1(old_board, i, j)
        end)
      end)

    if old_board != board, do: solve_part1(board), else: board
  end

  def part1(input) do
    final_board = solve_part1(input)

    final_board
    |> Enum.reduce(0, fn row, sum ->
      row
      |> Enum.reduce(sum, fn cell, sum ->
        if cell == "#", do: sum + 1, else: sum
      end)
    end)
  end

  def expand_out(board, i, j, di, dj) do
    i_prime = i + di
    j_prime = j + dj

    if within_bounds(board, i_prime, j_prime) do
      cell = cell_at(board, i_prime, j_prime)

      case cell do
        "L" -> 0
        "#" -> 1
        _ -> expand_out(board, i_prime, j_prime, di, dj)
      end
    else
      0
    end
  end

  def generate_new_cell_part2(board, i, j) do
    cell = cell_at(board, i, j)
    slopes = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]]

    sum =
      slopes
      |> Enum.reduce(0, fn [di, dj], acc ->
        acc + expand_out(board, i, j, di, dj)
      end)

    case cell do
      "#" ->
        if sum >= 5, do: "L", else: "#"

      "L" ->
        if sum == 0, do: "#", else: "L"

      "." ->
        "."
    end
  end

  def solve_part2(board) do
    old_board = Enum.to_list(board)

    board =
      board
      |> Enum.with_index()
      |> Enum.map(fn {row, j} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {_cell, i} ->
          generate_new_cell_part2(old_board, i, j)
        end)
      end)

    if old_board != board, do: solve_part2(board), else: board
  end

  def part2(input) do
    final_board = solve_part2(input)

    final_board
    |> Enum.reduce(0, fn row, sum ->
      row
      |> Enum.reduce(sum, fn cell, sum ->
        if cell == "#", do: sum + 1, else: sum
      end)
    end)
  end
end
