defmodule AOC.Day14 do
  use Bitwise

  def parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
  end

  def part1(input) do
    {memory, _mask} =
      input
      |> Enum.reduce({%{}, 0}, fn line, {memory, mask} ->
        mask_regex = ~r/^mask = (.*)$/
        mem_regex = ~r/^mem\[([[:digit:]]+)\] = (.*)$/

        cond do
          String.match?(line, mask_regex) ->
            [_, new_mask] = Regex.run(mask_regex, line)
            {memory, new_mask}

          String.match?(line, mem_regex) ->
            [_, address, value] = Regex.run(mem_regex, line)
            address = String.to_integer(address)
            value = String.to_integer(value)

            ones =
              mask
              |> String.graphemes()
              |> Enum.map(&if &1 != "1", do: 0, else: 1)
              |> Enum.reduce(0, fn i, acc ->
                acc <<< 1 ||| i
              end)

            zeroes =
              mask
              |> String.graphemes()
              |> Enum.map(&if &1 != "0", do: 1, else: 0)
              |> Enum.reduce(0, fn i, acc ->
                acc <<< 1 ||| i
              end)

            value = (value ||| ones) &&& zeroes
            memory = Map.put(memory, address, value)
            {memory, mask}
        end
      end)

      memory
      |> Enum.reduce(0, fn {_k, v}, acc ->
        acc + v
      end)
  end
end
