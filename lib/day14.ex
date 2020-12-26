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

  def fill_in_xs(address_with_xs, i) do
    address_with_xs
    |> Enum.reverse()
    |> Enum.map_reduce(i, fn digit, i ->
      case digit do
        "X" ->
          {(i &&& 1) |> Integer.to_string(), i >>> 1}

        _ ->
          {digit, i}
      end
    end)
    |> elem(0)
  end

  def part2(input) do
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
            value = String.to_integer(value)

            new_address =
              address
              |> String.to_integer()
              |> Integer.to_string(2)
              |> String.pad_leading(36, "0")
              |> String.graphemes()
              |> Enum.zip(String.graphemes(mask))
              |> Enum.map(fn {address_digit, mask_digit} ->
                case mask_digit do
                  "0" -> address_digit
                  "1" -> "1"
                  "X" -> "X"
                end
              end)

            num_xs =
              new_address
              |> Enum.reduce(0, fn digit, acc -> if digit == "X", do: acc + 1, else: acc end)

            addresses =
              0..((2 <<< num_xs) - 1)
              |> Enum.to_list()
              |> Enum.map(fn i ->
                fill_in_xs(new_address, i)
              end)

            memory =
              addresses
              |> Enum.reduce(memory, &Map.put(&2, &1, value))

            {memory, mask}
        end
      end)

    memory
    |> Enum.reduce(0, fn {_k, v}, acc ->
      acc + v
    end)
  end
end
