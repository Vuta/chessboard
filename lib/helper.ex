defmodule Helper do
  alias TableRex.Table
  import Bitwise

  def set_piece(board, square), do: board ||| (1 <<< square)

  def print_board(board) do
    for rank <- 7..0, file <- 0..7, into: [] do
      if (board &&& (1 <<< (rank * 8 + file))) == 0, do: 0, else: 1
    end
    |> Enum.chunk_every(8)
    |> Table.new()
    |> Table.render!(intersection_symbol: "|", horizontal_style: :all)
    |> IO.puts()
  end
end
