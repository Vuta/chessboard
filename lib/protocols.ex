defimpl String.Chars, for: Board do
  def to_string(board) do
    pieces = %{
      "\u2659" => board.w_pawns,
      "\u2658" => board.w_knights,
      "\u2657" => board.w_bishops,
      "\u2656" => board.w_rooks,
      "\u2655" => board.w_queens,
      "\u2654" => board.w_king,
      "\u265F" => board.b_pawns,
      "\u265E" => board.b_knights,
      "\u265D" => board.b_bishops,
      "\u265C" => board.b_rooks,
      "\u265B" => board.b_queens,
      "\u265A" => board.b_king
    }

    for rank <- 7..0, file <- 0..7, into: [] do
      {unicode, _} = Enum.find(pieces, {".", nil}, fn {_, piece_bits} ->
        square_value = Bitwise.bsl(1, rank * 8 + file)
        Bitwise.band(piece_bits, square_value) != 0
      end)

      unicode <> " "
    end
    |> Enum.chunk_every(8)
    |> Enum.join("\n")
  end
end
