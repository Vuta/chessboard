defmodule BishopAttacks do
  import Bitwise

  def mask(square) do
    current_rank = div(square, 8)
    current_file = rem(square, 8)

    one = for i <- (current_rank + 1)..6, j <- (current_file + 1)..6,
      i <= 6, j <= 6, i - current_rank == j - current_file, reduce: 0 do
      acc -> acc ||| 1 <<< (i * 8 + j)
    end

    two = for i <- (current_rank + 1)..6, j <- 1..(current_file - 1),
      current_file - 1 >= 1,
      i <= 6, j >= 1, i - current_rank == current_file - j, reduce: 0 do
      acc -> acc ||| 1 <<< (i * 8 + j)
    end

    three = for i <- 1..(current_rank - 1), j <- (current_file + 1)..6,
      current_rank - 1 >= 1,
      i >= 1, j <= 6, current_rank - i == j - current_file, reduce: 0 do
      acc -> acc ||| 1 <<< (i * 8 + j)
    end

    four = for i <- 1..(current_rank - 1), j <- 1..(current_file - 1),
      current_rank - 1 >= 1, current_file - 1 >= 1,
      i >= 1, j >= 1, current_rank - i == current_file - j, reduce: 0 do
      acc -> acc ||| 1 <<< (i * 8 + j)
    end

    one ||| two ||| three ||| four
  end
end
