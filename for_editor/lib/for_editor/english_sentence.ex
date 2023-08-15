defmodule ForEditor.EnglishSentence do
  @moduledoc """
  英文を管理するモジュールを提供します。
  英文=大文字から始まりピリオドで終わる語群。
  """

  @not_contraction_words ["isn't", "aren't","wasn't","weren't", "ain't"]

  @doc """
  英文をパースし、単語ごとのリストを作成します。

  ・".","?","!"は終端文字として扱います。
  ・終端文字は文の最後の文字
  ・"'"は文の途中でも分割します。
  ・"I'm" -> "I", "'", "m"
  ・ただし、notの短縮形は"n't"で分割します。
  ・"isn't" -> "is", "n't"

  ## パラメータ
  - input: 入力された文字列

  ## Examples

      iex> ForEditor.EnglishSentence.to_list("This is a pen.")
      ["This", "is", "a", "pen",  "."]

  """
  def parse( input ) do
    input
    |> String.split()
    |> terminate()
    |> split_character()
    |> split_not_contraction()
    |> Enum.filter(fn x -> x !== "" and x !== nil end)
  end

  def terminate([]), do: []
  def terminate([ head | tail]) do
    {result, split_character} = is_termination(head)

    if result do
      [a, b] = head |> String.split(split_character)
      [a, split_character, b | terminate(tail)]
    else
      [head | terminate(tail)]
    end
  end

  defp is_termination(token) do
    termination_chars = [".", "?", "!"]
    last_char_code = token
                    |> String.to_charlist()
                    |> List.last()
    last_char = <<last_char_code::utf8>>

    if Enum.member?(termination_chars, last_char) do
      {true, last_char}
    else
      {false, nil}
    end
  end




  def split_character([]), do: []
  def split_character([ head | tail]) do
    {result, split_character} = if Enum.any?(@not_contraction_words, fn word -> word == head end) do
      {false, nil}
    else
      is_split_character(head)
    end

    if result do
      [a, b] = head |> String.split(split_character)
      [a, split_character, b | split_character(tail)]
    else
      [head | split_character(tail)]
    end

  end


  defp is_split_character(token) do
    split_chars = ["'", ","]
    contained_chars = Enum.filter(split_chars, fn char -> String.contains?(token, char) end)

    #分割する文字が1つの場合
    if length(contained_chars) == 1 do
      {true, hd(contained_chars)}
    else
      {false, nil}
    end
  end

  def split_not_contraction([]), do: []
  def split_not_contraction([ head | tail]) do

    if Enum.any?(@not_contraction_words, fn word -> word == head end) do
      [a, _] = head |> String.split("n't")
      [a, "n't" | split_not_contraction(tail)]
    else
      [head | split_not_contraction(tail)]
    end

  end




end
