defmodule EtudeTest do
  use ExUnit.Case
  doctest Etude

  test "return `:ok` after output" do
    assert :ok == Etude.greet
  end
end
