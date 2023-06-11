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

  def relevant_blockers(mask) do
    Helper.carry_rippler(mask, Arrays.new([]))
  end

  def attack(square, blocker) do
    rank = div(square, 8)
    file = rem(square, 8)

    one = attack(0, rank + 1, file, 1, 0, blocker)
    two = attack(0, rank - 1, file, -1, 0, blocker)
    three = attack(0, rank, file + 1, 0, 1, blocker)
    four = attack(0, rank, file - 1, 0, -1, blocker)

    one ||| two ||| three ||| four
  end

  defp attack(result, 8, _, _, _, _), do: result
  defp attack(result, _, 8, _, _, _), do: result
  defp attack(result, -1, _, _, _, _), do: result
  defp attack(result, _, -1, _, _, _), do: result
  defp attack(result, rank, file, dr, df, blocker) do
    bit = 1 <<< (rank * 8 + file)
    result = result ||| bit

    if (bit &&& blocker) == 0 do
      attack(result, rank + dr, file + df, dr, df, blocker)
    else
      result
    end
  end
end
