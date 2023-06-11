defmodule Helper do
  alias TableRex.Table
  import Bitwise

  def set_piece(board, square), do: board ||| (1 <<< square)

  def count_bits(board) do
    for(<<bit::1 <- :binary.encode_unsigned(board)>>, do: bit) |> Enum.sum
  end

  def carry_rippler(mask, result) do
    result = Arrays.append(result, 0)
    subset = (0 - mask) &&& mask
    carry_rippler(subset, mask, result)
  end

  def generate_magic(square, :bishop) do
    mask = BishopAttacks.mask(square)
    blockers = BishopAttacks.relevant_blockers(mask)
    attacks = Enum.map(blockers, fn blocker ->
      BishopAttacks.attack(square, blocker)
    end)

    :rand.seed(:exsss, {1804289383, 1804289383, 1804289383})
    gen(0, mask, blockers, attacks)
  end

  def generate_magic(square, :rook) do
    mask = RookAttacks.mask(square)
    blockers = RookAttacks.relevant_blockers(mask)
    attacks = Enum.map(blockers, fn blocker ->
      RookAttacks.attack(square, blocker)
    end)

    :rand.seed(:exsss, {1804289383, 1804289383, 1804289383})
    gen(0, mask, blockers, attacks)
  end

  defp gen(100000000, _, _, _), do: :fail
  defp gen(i, mask, blockers, attacks) do
    magic = gen_random_magic()
    count = count_bits((mask * magic) &&& 0xFF00000000000000)

    if count < 6 do
      gen(i + 1, mask, blockers, attacks)
    else
      used = Arrays.new(Enum.map(0..4095, fn _i -> 0 end)) 
      {status, magic} = test_magic(0, false, magic, count_bits(mask), used, blockers, attacks)
      if status == :ok do
        magic
      else
        gen(i + 1, mask, blockers, attacks)
      end
    end
  end

  defp test_magic(_i, true, _magic, _count, _used, _blockers, _attacks), do: {:fail, 0}
  defp test_magic(i, _, magic, count, _used, _blockers, _attacks) when i == (1 <<< count), do: {:ok, magic}
  defp test_magic(i, fail, magic, count, used, blockers, attacks) do
    <<index::64>> = <<blockers[i] * magic::64>>
    index = index >>> (64 - count)
    attack = Enum.at(attacks, i)
    {a, b} = cond do
      used[index] == 0 ->
        used = put_in(used[index], attack)
        {used, fail}
      used[index] != attack ->
        {used, true}
      true -> {used, fail}
    end

    test_magic(i + 1, b, magic, count, a, blockers, attacks)
  end

  def print_board(board) do
    for rank <- 7..0, file <- 0..7, into: [] do
      if (board &&& (1 <<< (rank * 8 + file))) == 0, do: 0, else: 1
    end
    |> Enum.chunk_every(8)
    |> Table.new()
    |> Table.render!(intersection_symbol: "|", horizontal_style: :all)
    |> IO.puts()
  end

  defp carry_rippler(0, _mask, result), do: result

  defp carry_rippler(subset, mask, result) do
    result = Arrays.append(result, subset)
    subset = (subset - mask) &&& mask
    carry_rippler(subset, mask, result)
  end

  defp gen_random_magic do
    n1 = :rand.uniform(1804289383) &&& :rand.uniform(1804289383) &&& :rand.uniform(1804289383)
    n2 = :rand.uniform(1804289383) &&& :rand.uniform(1804289383) &&& :rand.uniform(1804289383)
    n3 = :rand.uniform(1804289383) &&& :rand.uniform(1804289383) &&& :rand.uniform(1804289383)
    n4 = :rand.uniform(1804289383) &&& :rand.uniform(1804289383) &&& :rand.uniform(1804289383)

    (n1 &&& 0xFFFF) ||| ((n2 &&& 0xFFFF) <<< 16) ||| ((n3 &&& 0xFFFF) <<< 32) ||| ((n4 &&& 0xFFFF) <<< 48)
  end
end
