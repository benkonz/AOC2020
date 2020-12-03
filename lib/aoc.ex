defmodule AOC do
  @moduledoc """
  Documentation for `AOC`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AOC.hello()
      :world

  """
  def hello do
    :world
  end

  def map_input_file(filename) do
    File.read(filename)
    |> elem(1)
    |> String.split("\n")
    |> Enum.map(fn s -> Integer.parse(s) |> elem(0) end)
  end
end
