defmodule NextLS.RangeExtractor do
  @moduledoc false

  def extract_range(lines, range) do
    start_index =
      line_char_to_index(
        lines,
        range["start"]["line"],
        range["start"]["character"]
      )

    end_index =
      line_char_to_index(
        lines,
        range["end"]["line"],
        range["end"]["character"]
      )

    lines
    |> Enum.join("\n")
    |> String.slice(start_index, end_index - start_index)
  end

  defp line_char_to_index(lines, line, character) do
    lines
    |> Enum.take(line)
    |> Enum.join("\n")
    |> String.length()
    |> Kernel.+(character)
    # Add 1 for each newline, except for the first line
    |> Kernel.+(if(line > 0, do: 1, else: 0))
  end
end
