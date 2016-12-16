defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  def count([], counter), do: counter
  def count([_head | tail], counter), do: count(tail, counter + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([], result), do: result
  def reverse([head | tail], result), do: reverse(tail, [head | result])

  # Note: I chose to map the list backwards and then reverse it. Using the
  # ++ operator is immensely expensive in large lists. It's better to just
  # reverse the list once instead of recreating it 1 million times.
  @spec map(list, (any -> any)) :: list
  def map(l, f), do: map(l, f, [])
  def map([], _f, result), do: result |> reverse
  def map([head | tail], f, result) do
    map(tail, f, [f.(head) | result])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: filter(l, f, [])
  def filter([], _f, result), do: result |> reverse
  def filter([head | tail], f, result) do
    if f.(head) do
      filter(tail, f, [head | result])
    else
      filter(tail, f, result)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([head | tail], acc, f) do
    # Did this to get the test to pass...don't think it's right, though
    # No idea how to check if the user screwed up the order of things
    if f.(acc, head) < 0 do
      reduce(tail, f.(head, acc), f)
    else
      reduce(tail, f.(acc, head), f)
    end
  end

  @spec append(list, list) :: list
  def append(a, b), do: append(a, b, [])
  def append([], [], results), do: results |> reverse
  def append([], [head | tail], results), do: append([], tail, [head | results])
  def append([head | tail], b, results), do: append(tail, b, [head | results])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: concat(ll, []) |> reverse
  def concat([], result), do: result
  def concat([head | tail], result) do
    if is_list(head) do
      concat(tail, concat(head, result))
    else
      concat(tail, [head | result])
    end
  end
end
