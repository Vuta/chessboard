defmodule Helper do
  alias TableRex.Table
  import Bitwise

  def set_piece(board, square), do: board ||| (1 <<< square)

  def carry_rippler(mask, result) do
    result = Arrays.append(result, 0)
    subset = (0 - mask) &&& mask
    carry_rippler(subset, mask, result)
  end

  def print_board(board) do
    for rank <- 7..0, file <- 0..7, into: [] do
      if (board &&& (1 <<< (rank * 8 + file))) == 0, do: 0, else: 1
    end
    |> Enum.chunk_every(8)
    |> Table.new()
    |> Table.render!(intersection_symbol: "|", horizontal_style: :all)
    |> IO.puts()
  end

  defp carry_rippler(0, _mask, result), do: result

  defp carry_rippler(subset, mask, result) do
    result = Arrays.append(result, subset)
    subset = (subset - mask) &&& mask
    carry_rippler(subset, mask, result)
  end
end
