if Code.ensure_loaded?(StreamData) do
  defmodule ExchemaExtra.StreamData.CNPJ do
    alias ExchemaExtra.Types.CNPJ
    import StreamData

    def override(CNPJ, _) do
      map(nil, fn _ -> Brcpfcnpj.cnpj_generate() end)
    end

    def override(_, original), do: original
  end
end
