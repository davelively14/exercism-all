defmodule BankAccount do
  use GenServer
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  #######
  # API #
  #######

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    unless is_online? do
      GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
    end
    GenServer.call(__MODULE__, :add_account)
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(__MODULE__, {:balance, account})
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
  end

  def is_online?, do: if GenServer.whereis(__MODULE__), do: true, else: false

  #############
  # Callbacks #
  #############

  def init do
    new_state = %{accounts: [], counter: 0}
    {:ok, new_state}
  end

  def handle_call(:add_account, _from, state) do
    new_account = %{acct_num: state.counter + 1, balance: 0}
    new_state =
      Map.put(state, :accounts, [new_account | state.accounts])
      |> Map.put(state, :counter, state.counter + 1)
    {:ok, new_state.counter, new_state}
  end

  def handle_call({:balance, account}, _from, state) do
    {:reply, state.balance, state}
  end
end
