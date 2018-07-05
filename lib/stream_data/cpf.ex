if Code.ensure_loaded?(StreamData) do
  defmodule ExchemaExtra.StreamData.CPF do
    alias ExchemaExtra.Types.CPF
    import StreamData

    def override(CPF, _) do
      map(nil, fn _ -> Brcpfcnpj.cpf_generate() end)
    end

    def override(_, original), do: original
  end
end
