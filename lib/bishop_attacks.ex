defmodule BishopAttacks do
  import Bitwise

  def mask(square) do
    rank = div(square, 8)
    file = rem(square, 8)

    one = mask(0, rank + 1, file + 1, 1, 1)
    two = mask(0, rank + 1, file - 1, 1, -1)
    three = mask(0, rank - 1, file + 1, -1, 1)
    four =  mask(0, rank - 1, file - 1, -1, -1)

    one ||| two ||| three ||| four
  end

  def relevant_blockers(mask) do
    Helper.carry_rippler(mask, Arrays.new([]))
  end

  def attack(square, blocker) do
    rank = div(square, 8)
    file = rem(square, 8)

    one = attack(0, rank + 1, file + 1, 1, 1, blocker)
    two = attack(0, rank + 1, file - 1, 1, -1, blocker)
    three = attack(0, rank - 1, file + 1, -1, 1, blocker)
    four =  attack(0, rank - 1, file - 1, -1, -1, blocker)

    one ||| two ||| three ||| four
  end

  def attack(result, 8, _, _, _, _), do: result
  def attack(result, _, 8, _, _, _), do: result
  def attack(result, -1, _, _, _, _), do: result
  def attack(result, _, -1, _, _, _), do: result
  def attack(result, rank, file, dr, df, blocker) do
    bit = 1 <<< (rank * 8 + file)
    result = result ||| bit

    if (bit &&& blocker) == 0 do
      attack(result, rank + dr, file + df, dr, df, blocker)
    else
      result
    end
  end

  defp mask(result, 8, _, _, _), do: result
  defp mask(result, _, 8, _, _), do: result
  defp mask(result, -1, _, _, _), do: result
  defp mask(result, _, -1, _, _), do: result
  defp mask(result, rank, file, dr, df) do
    bit = 1 <<< (rank * 8 + file)

    mask(result ||| bit, rank + dr, file + df, dr, df)
  end
end
