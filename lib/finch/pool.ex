defmodule Finch.Pool do
  @moduledoc false
  # Defines a behaviour that both http1 and http2 pools need to implement.

  @type request_ref :: {pool_mod :: module(), cancel_ref :: term()}

  @callback request(pid(), Finch.Request.t(), acc, Finch.stream(acc), list()) ::
              {:ok, acc} | {:error, term()}
            when acc: term()

  @callback async_request(pid(), Finch.Request.t(), list()) :: request_ref()

  @callback cancel_async_request(request_ref()) :: :ok

  defguard is_request_ref(ref) when tuple_size(ref) == 2 and is_atom(elem(ref, 0))
end
