defmodule Masks do
  # 1 1 1 1 1 1 1 0
  # 1 1 1 1 1 1 1 0
  # 1 1 1 1 1 1 1 0
  # 1 1 1 1 1 1 1 0
  # 1 1 1 1 1 1 1 0
  # 1 1 1 1 1 1 1 0
  # 1 1 1 1 1 1 1 0
  # 1 1 1 1 1 1 1 0
  def clear_h_file, do: 0x7F7F7F7F7F7F7F7F

  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  def clear_a_file, do: 0xFEFEFEFEFEFEFEFE
end
