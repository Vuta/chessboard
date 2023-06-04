defmodule RookAttacks do
  import Bitwise

  def mask(square) do
    current_rank = div(square, 8)
    current_file = rem(square, 8)

    file_mask =
      [1, 2, 3, 4, 5, 6]
      |> List.delete(current_rank)
      |> Enum.reduce(0, fn rank, acc ->
        acc ||| (1 <<< rank * 8 + current_file)
      end)

    rank_mask =
      [1, 2, 3, 4, 5, 6]
      |> List.delete(current_file)
      |> Enum.reduce(0, fn file, acc ->
        acc ||| (1 <<< current_rank * 8 + file)
      end)

    file_mask ||| rank_mask
  end
end
