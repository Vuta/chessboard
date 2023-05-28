defmodule Ares do
  def print_board(board = %Board{}) do
    board
    |> to_string()
    |> IO.puts()
  end
end
