if Code.ensure_loaded?(StreamData) and Code.ensure_loaded?(UUID) do
  defmodule ExchemaExtra.StreamData.UUID do
    alias ExchemaExtra.Types
    import StreamData

    def override({Types.UUID, {}}, _) do
      generator(:any, :any)
    end

    def override(Types.UUID, _) do
      generator(:any, :any)
    end

    def override({Types.UUID, {version, format}}, _) do
      generator(version, format)
    end

    def override(_, original), do: original

    defp generator(version, format) do
      case version do
        1 ->
          map(fmt_gen(format), &UUID.uuid1(&1))

        3 ->
          map(fmt_gen(format), &UUID.uuid3(UUID.uuid1(), UUID.uuid1(), &1))

        4 ->
          map(fmt_gen(format), &UUID.uuid4(&1))

        5 ->
          map(fmt_gen(format), &UUID.uuid5(UUID.uuid1(), UUID.uuid1(), &1))

        :any ->
          [1, 3, 4, 5] |> Enum.map(&generator(&1, format)) |> one_of()
      end
    end

    defp fmt_gen(:any), do: one_of([:hex, :default, :urn])
    defp fmt_gen(fmt), do: constant(fmt)
  end
end
