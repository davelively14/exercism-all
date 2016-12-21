defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown |> String.split("\n") |> Enum.map(&process(&1)) |> Enum.join |> patch
  end

  # Changed nested 'if' statements to a cond do
  defp process(text) do
    cond do
      String.starts_with?(text, "#") ->
        text |> parse_header_md_level |> enclose_with_header_tag
      String.starts_with?(text, "*") ->
        text |> parse_list_md_level
      true ->
        text |> String.split |> enclose_with_paragraph_tag
    end
  end

  # Deterines header level
  # This will count the number of # and display the result as a tuple. Ex:
  # "#### This is the title" will become {4, "This is the title"}
  defp parse_header_md_level(hwt) do
    [head | tail] = String.split(hwt)
    {head |> String.length |> to_string, tail |> Enum.join(" ")}
  end


  defp parse_list_md_level(l) do
    t = String.split(String.trim_leading(l, "* "))
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h" <> hl <> ">" <> htl <> "</h" <> hl <> ">"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    Enum.join(Enum.map(t, fn(w) -> replace_md_with_tag(w) end), " ")
  end

  defp replace_md_with_tag(w) do
    replace_suffix_md(replace_prefix_md(w))
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp patch(l) do
    String.replace_suffix(String.replace(l, "<li>", "<ul>" <> "<li>", global: false), "</li>", "</li>" <> "</ul>")
  end
end
