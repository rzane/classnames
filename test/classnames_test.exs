defmodule ClassnamesTest do
  use ExUnit.Case
  use Classnames

  doctest Classnames

  test "the macro brings in the `classnames` fun" do
    assert classnames([:one]) == "one"
  end
end
