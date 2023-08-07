defmodule ForEditor.EnglishSentence do
  @moduledoc """
  Documentation for `ForEditor`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ForEditor.hello()
      :world

  """

  def to_list( input ) do
    input |> String.split() |> termination()
  end



  #終端文字の対応
  defp termination([]), do: []
  defp termination([ head | tail]) do
    {result, terminating_character} = is_terminating_character(head)

    if result do
      split_terminate = head |> String.split(terminating_character)
      Enum.map(split_terminate, fn(x) -> set_termination(x, terminating_character) end)
    else
      [head | termination(tail)]
    end
  end


  defp is_terminating_character(token) do
    terminating_character = [".", "?", "!"]
    {_, last_char} = String.split_at(token, -1)
    if Enum.member?(terminating_character, last_char) do
      {true, last_char}
    else
      {false, nil}
    end
  end


  defp set_termination(x,terminating_character) do
    if String.length(x) == 0 do
      String.replace(x,"",terminating_character)
    else
      x
    end
  end
end
