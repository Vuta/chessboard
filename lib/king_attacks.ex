defmodule KingAttacks do
  import Bitwise

  def table do
    0..63
    |> Enum.map(&generate_attacks/1)
    |> Arrays.new()
  end

  def generate_attacks(square) do
    board = Helper.set_piece(0, square)

    one = (board <<< 8)
    two = (board <<< 9) &&& Masks.clear_a_file()
    three = (board <<< 7) &&& Masks.clear_h_file()
    four = (board <<< 1) &&& Masks.clear_a_file()

    five = (board >>> 8)
    six = (board >>> 9) &&& Masks.clear_h_file()
    seven = (board >>> 7) &&& Masks.clear_a_file()
    eight = (board >>> 1) &&& Masks.clear_h_file()

    one ||| two ||| three ||| four ||| five ||| six ||| seven ||| eight
  end
end
