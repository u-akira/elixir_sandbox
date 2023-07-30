
defmodule TestToken do
  def pattern1 do
    input = "This is a pen."

    assert = input
    |> String.split()
    |> Token.termination()
    |> Token.delimiter()

    ^assert = ["/", "This", "/", "is", "/", "a", "/", "pen", "/", "."]

  end
end
