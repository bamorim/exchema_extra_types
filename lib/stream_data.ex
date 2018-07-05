if Code.ensure_loaded?(StreamData) do
  defmodule ExchemaExtra.StreamData do
    @overrides []

    if Code.ensure_loaded?(UUID) do
      @overrides [ExchemaExtra.StreamData.UUID | @overrides]
    end

    def override(original, type) do
      Enum.reduce(@overrides, original, &(&1.override(&2, type)))
    end
  end
end
