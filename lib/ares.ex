defmodule Ares do
  def print_board(board = %Board{}) do
    IO.inspect("Active color: #{board.active}, castle: #{board.castle}, enpassant: #{board.enpassant}, half move: #{board.half_move}, full move: #{board.full_move}")
    board
    |> to_string()
    |> IO.puts()
  end
end
