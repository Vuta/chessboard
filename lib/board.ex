defmodule Board do
  defstruct active: :white,
    castle: 0b0000,
    enpassant: nil,
    half_move: 0,
    full_move: 0,
    position: %{
      w_pawns: 0x0000000000000000,
      w_knights: 0x0000000000000000,
      w_bishops: 0x0000000000000000,
      w_rooks: 0x0000000000000000,
      w_queens: 0x0000000000000000,
      w_king: 0x0000000000000000,
      b_pawns: 0x0000000000000000,
      b_knights: 0x0000000000000000,
      b_bishops: 0x0000000000000000,
      b_rooks: 0x0000000000000000,
      b_queens: 0x0000000000000000,
      b_king: 0x0000000000000000
    }
end
