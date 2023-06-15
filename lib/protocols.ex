defimpl String.Chars, for: Board do
  def to_string(board) do
    alias TableRex.Table

    position = board.position

    pieces = %{
      "\u2659" => position.w_pawns,
      "\u2658" => position.w_knights,
      "\u2657" => position.w_bishops,
      "\u2656" => position.w_rooks,
      "\u2655" => position.w_queens,
      "\u2654" => position.w_king,
      "\u265F" => position.b_pawns,
      "\u265E" => position.b_knights,
      "\u265D" => position.b_bishops,
      "\u265C" => position.b_rooks,
      "\u265B" => position.b_queens,
      "\u265A" => position.b_king
    }

    for rank <- 7..0, file <- 0..7, into: [] do
      {unicode, _} = Enum.find(pieces, {"", nil}, fn {_, piece_bits} ->
        square_value = Bitwise.bsl(1, rank * 8 + file)
        Bitwise.band(piece_bits, square_value) != 0
      end)

      unicode
    end
    |> Enum.chunk_every(8)
    |> Table.new()
    |> Table.render!(intersection_symbol: "|", horizontal_style: :all)
  end
end
