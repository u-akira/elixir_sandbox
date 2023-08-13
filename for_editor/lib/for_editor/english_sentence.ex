defmodule ForEditor.EnglishSentence do
  @moduledoc """
  英文を管理するモジュールを提供します。
  英文=大文字から始まりピリオドで終わる語群。
  """

  @doc """
  英文をパースし、リストを作成します。

  ・".","?","!"は終端文字として扱います。
  ・"'"は省略記法の場合、分割します
    "I'm", "They're"など
  ## パラメータ
  - input: 入力された文字列

  ## Examples

      iex> ForEditor.EnglishSentence.to_list("This is a pen.")
      ["This", "is", "a", "pen",  "."]

  """
  def to_list( input ) do
    input
    |> String.split()
    |> parse()

    #|> split_character()
    |> Enum.filter(fn x -> x !== "" and x !== nil end)
  end

  def parse([]), do: []
  def parse([ head | tail]) do
    {is_termination, split_character} = is_termination(head)

    if is_termination do
      [a, b] = head |> String.split(split_character)
      [a, split_character, b | parse(tail)]
    else
      [head | parse(tail)]
    end
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

  def is_termination(token) do
    termination_chars = [".", "?", "!"]
    last_char_code = token |> String.to_charlist()
                      |> List.last()
    last_char = <<last_char_code::utf8>>

    if Enum.member?(termination_chars, last_char) do
      {true, last_char}
    else
      {false, nil}
    end
  end

  """
  defp is_terminating_character(token) do
    terminating_character = [".", "?", "!"]
    {_, last_char} = String.split_at(token, -1)
    if Enum.member?(terminating_character, last_char) do
      {true, last_char}
    else
      {false, nil}
    end
  end
  """

end
