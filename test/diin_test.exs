defmodule DiinTest do
  use ExUnit.Case
  doctest Diin

  test "works" do
    assert Diin.parse([deps: %{a: 2}, deps: %{a: 3}], %{a: 1}) == %{a: 2}
    assert Diin.parse([], %{a: 1}) == %{a: 1}
  end
end
