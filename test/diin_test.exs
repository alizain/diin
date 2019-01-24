defmodule DiinTest do
  use ExUnit.Case
  doctest Diin

  test "greets the world" do
    assert Diin.hello() == :world
  end
end
