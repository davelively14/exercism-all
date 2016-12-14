defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @dna_to_rna %{?G => 'C', ?C => 'G', ?T => 'A', ?A => 'U'}

  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: to_rna(dna, '')
  def to_rna([], result), do: result
  def to_rna([head | tail], result), do: to_rna(tail, result ++ @dna_to_rna[head])
end
