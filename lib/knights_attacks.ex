defmodule KnightsAttacks do
  import Bitwise

  def table do
    0..63
    |> Enum.map(&generate_attacks/1)
    |> List.to_tuple()
  end

  defp generate_attacks(square) do
    board = Helper.set_piece(0, square)

    one = (board <<< 17) &&& Masks.clear_a_file()
    two = (board <<< 15) &&& Masks.clear_h_file()
    three = (board <<< 10) &&& Masks.clear_ab_file()
    four = (board <<< 6) &&& Masks.clear_gh_file()
    five = (board >>> 15) &&& Masks.clear_a_file()
    six = (board >>> 17) &&& Masks.clear_h_file()
    seven = (board >>> 6) &&& Masks.clear_ab_file()
    eight = (board >>> 10) &&& Masks.clear_gh_file()

    one ||| two ||| three ||| four ||| five ||| six ||| seven ||| eight
  end
end
