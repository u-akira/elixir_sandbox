
defmodule EnglishSentenceTest do
  use ExUnit.Case
  doctest ForEditor

  import ForEditor.EnglishSentence

  test "'This is a pen.' to list" do
    assert "This is a pen." |> to_list()  == ["This", "is", "a", "pen",  "."]
  end

  test "'Are you hungry?' to list" do
    assert "Are you hungry?" |> to_list()  == ["Are", "you", "hungry", "?"]
  end

  test "'I'm from Osaka!' to list" do
    assert "I'm from Osaka!" |> to_list()  == ["I","'","m", "from", "Osaka", "!"]
  end

end
