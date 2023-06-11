defmodule BishopAttacks do
  import Bitwise

  @mask_bits_count Arrays.new([
    6, 5, 5, 5, 5, 5, 5, 6, 5, 5, 5, 5, 5, 5, 5, 5,
    5, 5, 7, 7, 7, 7, 5, 5, 5, 5, 7, 9, 9, 7, 5, 5,
    5, 5, 7, 9, 9, 7, 5, 5, 5, 5, 7, 7, 7, 7, 5, 5,
    5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 5, 5, 5, 5, 5, 6
  ])

  def table do
    magic = %Magic{}.bishop
    Enum.map(0..63, fn square ->
      mask = mask(square)
      blockers = relevant_blockers(mask)
      count = @mask_bits_count[square]
      arr = Arrays.new(0..(1 <<< count))
      Enum.reduce(blockers, arr, fn blocker, attacks ->
        <<index::64 >> = <<blocker * magic[square]::64>>
        index = index >>> (64 - count)
        attacks = put_in(attacks[index], attack(square, blocker))

        attacks
      end)
    end)
  end

  def test do
    table = table()
    Enum.each(63..0, fn square ->
      mask = mask(square)
      blockers = relevant_blockers(mask)
      IO.puts("=========== Mask #{square} ================")
      Helper.print_board(mask)

      Enum.each(blockers, fn blocker ->
        IO.puts("=========== Blocker #{blocker} ================")
        Helper.print_board(blocker)

        attack = get(table, square, blocker)
        IO.puts("=========== Attack #{attack} ================")
        Helper.print_board(attack)

        IO.gets("continue?")
      end)
    end)
  end

  def get(table, square, blocker) do
    magic = %Magic{}.bishop
    mask = mask(square)
    blocker = blocker &&& mask
    <<index::64>> = <<blocker * magic[square]::64>>
    index = index >>> (64 - @mask_bits_count[square])

    Enum.at(table, square)[index]
  end

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

  defp mask(result, rank, _file, _, _) when rank >= 7, do: result
  defp mask(result, _rank, file, _, _) when file >= 7, do: result
  defp mask(result, rank, _file, _, _) when rank <= 0, do: result
  defp mask(result, _rank, file, _, _) when file <= 0, do: result
  defp mask(result, rank, file, dr, df) do
    bit = 1 <<< (rank * 8 + file)

    mask(result ||| bit, rank + dr, file + df, dr, df)
  end
end
