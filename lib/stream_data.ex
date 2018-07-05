if Code.ensure_loaded?(StreamData) do
  defmodule ExchemaExtra.StreamData do
    alias ExchemaExtra.StreamData, as: SD

    @overrides [SD.CPF, SD.CNPJ]

    if Code.ensure_loaded?(UUID) do
      @overrides [SD.UUID | @overrides]
    end

    def override(type, original) do
      Enum.reduce(@overrides, original, fn mod, gen ->
        mod.override(type, gen)
      end)
    end
  end
end
