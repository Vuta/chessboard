defmodule KnightsAttacksTest do
  use ExUnit.Case

  import Bitwise

  setup_all do
    {:ok, table: KnightsAttacks.table()}
  end

  # a8 b8 c8 d8 e8 f8 g8 h8      56 57 58 59 60 61 62 63
  # a7 b7 c7 d7 e7 f7 g7 h7      48 49 50 51 52 53 54 55
  # a6 b6 c6 d6 e6 f6 g6 h6      40 41 42 43 44 45 46 47
  # a5 b5 c5 d5 e5 f5 g5 h5  =>  32 33 34 35 36 37 38 39
  # a4 b4 c4 d4 e4 f4 g4 h4      24 25 26 27 28 29 30 31
  # a3 b3 c3 d3 e3 f3 g3 h3      16 17 18 19 20 21 22 23
  # a2 b2 c2 d2 e2 f2 g2 h2      8  9  10 11 12 13 14 15
  # a1 b1 c1 d1 e1 f1 g1 h1      0  1   2  3  4  5  6  7

  # TODO: Complete this
  test "attack table for knights is generated correctly", state do
    squares =
      Enum.to_list(18..21) ++
      Enum.to_list(26..29) ++
      Enum.to_list(34..37) ++
      Enum.to_list(42..45)

    for n <- squares do
      board = set_board(n + 17, n + 15, n + 10, n + 6, n - 15, n - 17, n - 6, n - 10)

      assert board == state[:table][n]
    end
  end

  defp set_board(a, b, c, d, e, f, g, h) do
    Helper.set_piece(0, a) ||| Helper.set_piece(0, b) |||
      Helper.set_piece(0, c) ||| Helper.set_piece(0, d) |||
      Helper.set_piece(0, e) ||| Helper.set_piece(0, f) |||
      Helper.set_piece(0, g) ||| Helper.set_piece(0, h)
  end
end
