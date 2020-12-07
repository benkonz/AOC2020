defmodule AOC.Day4 do
  def parse_input(input) do
    File.read(input)
    |> elem(1)
    |> String.split("\n\n")
  end

  def part1(input) do
    required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] |> MapSet.new()
    optional = ["cid"] |> MapSet.new()

    input
    |> Enum.reduce(0, fn passport, acc ->
      regex = ~r/( |\n|\t)+/
      fields_and_value = String.split(passport, regex, trim: true)

      fields =
        fields_and_value
        |> Enum.map(fn field_and_value ->
          field_and_value |> String.split(":") |> Enum.at(0)
        end)
        |> MapSet.new()

      without_optional = MapSet.difference(fields, optional)

      if MapSet.equal?(without_optional, required) do
        acc + 1
      else
        acc
      end
    end)
  end

  def part2(input) do
    required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] |> MapSet.new()
    optional = ["cid"] |> MapSet.new()

    input
    |> Enum.reduce(0, fn passport, acc ->
      regex = ~r/( |\n|\t)+/
      fields_and_value = String.split(passport, regex, trim: true)

      fields =
        fields_and_value
        |> Enum.reduce([], fn field_and_value, acc ->
          [field, value] = field_and_value |> String.split(":")

          if is_value_valid(field, value) do
            [field | acc]
          else
            acc
          end
        end)
        |> MapSet.new()

      without_optional = MapSet.difference(fields, optional)

      if MapSet.equal?(without_optional, required) do
        acc + 1
      else
        acc
      end
    end)
  end

  def is_value_valid(field, value) do
    case field do
      "byr" ->
        if String.length(value) == 4 do
          value_num = Integer.parse(value) |> elem(0)
          value_num >= 1920 && value_num <= 2002
        else
          false
        end

      "iyr" ->
        if String.length(value) == 4 do
          value_num = Integer.parse(value) |> elem(0)
          value_num >= 2010 && value_num <= 2020
        else
          false
        end

      "eyr" ->
        if String.length(value) == 4 do
          value_num = Integer.parse(value) |> elem(0)
          value_num >= 2020 && value_num <= 2030
        else
          false
        end

      "hgt" ->
        if String.ends_with?(value, "cm") do
          value_num = Integer.parse(value) |> elem(0)
          value_num >= 150 && value_num <= 193
        else
          if String.ends_with?(value, "in") do
            value_num = Integer.parse(value) |> elem(0)
            value_num >= 59 && value_num <= 76
          else
            false
          end
        end

      "hcl" ->
        regex = ~r/^\#[a-f0-9]{6}$/
        Regex.match?(regex, value)

      "ecl" ->
        regex = ~r/^amb|blu|brn|gry|grn|hzl|oth$/
        Regex.match?(regex, value)

      "pid" ->
        String.length(value) == 9

      _ ->
        false
    end
  end
end
