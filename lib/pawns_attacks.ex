defmodule PawnsAttacks do
  import Bitwise

  def table do
    white_table =
      0..63
      |> Enum.map(&(generate_attacks(:white, &1)))
      |> List.to_tuple()

    black_table =
      0..63
      |> Enum.map(&(generate_attacks(:black, &1)))
      |> List.to_tuple()

    {white_table, black_table}
  end

  defp generate_attacks(:white, square) do
    board = Helper.set_piece(0, square)

    north_east = (board <<< 9) &&& Masks.clear_a_file()
    north_west = (board <<< 7) &&& Masks.clear_h_file()

    north_east ||| north_west
  end

  defp generate_attacks(:black, square) do
    board = Helper.set_piece(0, square)

    south_east = (board >>> 9) &&& Masks.clear_h_file()
    south_west = (board >>> 7) &&& Masks.clear_a_file()

    south_east ||| south_west
  end
end
