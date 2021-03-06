defmodule AOC.Day8 do
  def parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [instruction, arg_str] ->
      [instruction, String.to_integer(arg_str)]
    end)
  end

  def execute_instruction([operator, arg], pc, acc) do
    case operator do
      "nop" -> [pc + 1, acc]
      "acc" -> [pc + 1, acc + arg]
      "jmp" -> [pc + arg, acc]
    end
  end

  def execute_instructions(instructions, pc, acc, processed_lines) do
    if pc >= length(instructions) do
      [acc, true]
    else
      if MapSet.member?(processed_lines, pc) do
        [acc, false]
      else
        processed_lines = MapSet.put(processed_lines, pc)
        instruction = instructions |> Enum.at(pc)
        [pc, acc] = execute_instruction(instruction, pc, acc)
        execute_instructions(instructions, pc, acc, processed_lines)
      end
    end
  end

  def part1(input) do
    [acc, _finished] = execute_instructions(input, 0, 0, MapSet.new())
    acc
  end

  def part2(input) do
    input
    |> Enum.with_index()
    |> Enum.find_value(fn {instruction, line_num} ->
      new_instruction =
        case instruction do
          ["nop", arg] -> ["jmp", arg]
          ["jmp", arg] -> ["nop", arg]
          _ -> instruction
        end

      new_instructions = List.replace_at(input, line_num, new_instruction)
      [acc, finished] = execute_instructions(new_instructions, 0, 0, MapSet.new())

      if finished, do: acc, else: nil
    end)
  end
end
