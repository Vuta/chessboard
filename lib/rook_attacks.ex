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
    current_rank = div(square, 8)
    current_file = rem(square, 8)

    file_attack =
      [1, 2, 3, 4, 5, 6, 7]
      |> List.delete(current_rank)
      |> Enum.reduce_while(0, fn rank, acc ->
        bit = 1 <<< (rank * 8 + current_file)
        acc = acc ||| bit

        if (bit &&& blocker) == 0 do
          {:cont, acc}
        else
          {:halt, acc}
        end
      end)

    rank_attack =
      [1, 2, 3, 4, 5, 6, 7]
      |> List.delete(current_file)
      |> Enum.reduce_while(0, fn file, acc ->
        bit = 1 <<< (current_rank * 8 + file)
        acc = acc ||| bit

        if (bit &&& blocker) == 0 do
          {:cont, acc}
        else
          {:halt, acc}
        end
      end)

    file_attack ||| rank_attack
  end
end
