if Code.ensure_loaded?(UUID) do
  defmodule ExchemaExtra.Types.UUID do
    @moduledoc """
    This type models UUID strings.

    It is a parametric type that accepts two arguments (version and format).
    By default, it accepts all versions and formats (using version and format with :any)

    So, in other words
    `ExchemaExtra.Types.UUID` is the same as `{ExchemaExtra.Types.UUID, {:any, :any}}`

    The first argument is the version and the last is the format. So
    `{ExchemaExtra.Types.UUID, {4, :default}}` accets only UUID encoded in default format with
    version 4.

    # Examples

        iex> Exchema.is?(UUID.uuid4, ExchemaExtra.Types.UUID)
        true

        iex> Exchema.is?(UUID.uuid4(:urn), ExchemaExtra.Types.UUID)
        true

        iex> Exchema.is?(UUID.uuid1(:hex), ExchemaExtra.Types.UUID)
        true

        iex> Exchema.is?("notanuuid", ExchemaExtra.Types.UUID)
        false

        iex> Exchema.is?(UUID.uuid4, {Exchema.Types.UUID, {4, :any}})
        true

        iex> Exchema.is?(UUID.uuid4(:urn), {Exchema.Types.UUID, {4, :any}})
        true

        iex> Exchema.is?(UUID.uuid1, {Exchema.Types.UUID, {4, :any}})
        false

        iex> Exchema.is?(UUID.uuid1, {Exchema.Types.UUID, {1, :any}})
        true

        iex> Exchema.is?(UUID.uuid4, {Exchema.Types.UUID, {:any, :hex}})
        false

        iex> Exchema.is?(UUID.uuid4(:hex), {Exchema.Types.UUID, {:any, :hex}})
        true
    """

    @type t :: String.t()

    def __type__({}), do: __type__({:any, :any})

    def __type__({version, format}) do
      {:ref, Exchema.Types.String, [{{__MODULE__, :predicate}, {version, format}}]}
    end

    def predicate(input, {version, format}) when is_binary(input) do
      with {:ok, info} <- check_info(input),
           :ok <- check_version(version, info[:version]),
           :ok <- check_format(format, info[:type]),
           do: :ok
    end

    def predicate(_, _), do: :ok

    def check_info(input) do
      case UUID.info(input) do
        {:ok, info} ->
          {:ok, info}

        _ ->
          {:error, :not_an_uuid}
      end
    end

    defp check_version(version, actual_version),
      do: check_equal_or_any(version, actual_version, :invalid_version)

    defp check_format(format, actual_format),
      do: check_equal_or_any(format, actual_format, :invalid_format)

    defp check_equal_or_any(value, actual_value, error)
         when value != :any and actual_value != value,
         do: {:error, error}

    defp check_equal_or_any(_, _, _), do: :ok
  end
end
