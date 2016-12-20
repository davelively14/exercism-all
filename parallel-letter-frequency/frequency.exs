defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    Supervisor.start_child(Frequency.Supervisor, [])
  end
end

defmodule Frequency.Worker do
  def start_link(texts) do
    GenServer.start_link(__MODULE__, texts)
  end
end

defmodule Frequency.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    opts = [strategy: :simple_one_for_one]
    children = [worker(Frequency.worker, [])]

    supervise([], opts)
  end
end

defmodule Frequency.Server do
  use GenServer
  import Supervisor.Spec

  #######
  # API #
  #######

  def start_link() do

  end
end
