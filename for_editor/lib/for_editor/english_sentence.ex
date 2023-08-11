defmodule ForEditor.EnglishSentence do
  @moduledoc """
  英文を管理するモジュールを提供します。
  英文=大文字から始まりピリオドで終わる語群。
  """

  @doc """
  英文をlistにします。
  ".","?","."は終端文字として扱います。
  "'"は前後の単語を分割します。
  ## パラメータ
  - input: 入力された文字列

  ## Examples

      iex> ForEditor.EnglishSentence.to_list("This is a pen.")
      ["This", "is", "a", "pen",  "."]

  """
  def to_list( input ) do
    input
    |> String.split()
    |> split_character()
    |> Enum.filter(fn x -> x !== "" and x !== nil end)
  end


  def split_character([]), do: []
  def split_character([ head | tail]) do
    {result, split_character} = is_split_character(head)

    if result do
      [a, b] = head |> String.split(split_character)
      [a, split_character, b | split_character(tail)]
    else
      [head | split_character(tail)]
    end

  end


  defp is_split_character(token) do
    split_character = [".", "?", "!", "'"]
    contained_chars = Enum.filter(split_character, fn char -> String.contains?(token, char) end)

    if length(contained_chars) == 1 do
      {true, hd(contained_chars)}
    else
      {false, nil}
    end
  end

end
