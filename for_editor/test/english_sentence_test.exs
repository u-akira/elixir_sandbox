
defmodule EnglishSentenceTest do
  use ExUnit.Case
  doctest ForEditor

  import ForEditor.EnglishSentence

  test "'This is a pen.' to list" do
    assert "This is a pen." |> to_list()  == ["This", "is", "a", "pen",  "."]
  end

end
