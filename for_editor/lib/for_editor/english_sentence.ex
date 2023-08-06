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
  #ピリオド以外の文字も対応したい ?, !
  defp termination([]), do: []
  defp termination([ head | tail]) do
    if String.contains?(head, ".") do
      split_terminate = head |> String.split(".")
      Enum.map(split_terminate, fn(x) -> set_termination(x) end)
    else
      [head | termination(tail)]
    end
  end

  defp set_termination(x) do
    if String.length(x) == 0 do
      String.replace(x,"",".")
    else
      x
    end
  end
end
