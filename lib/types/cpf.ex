defmodule ExchemaExtra.Types.CPF do
  import Exchema.Notation

  @type t :: String.t()

  subtype(Exchema.Types.String, fn number ->
    if Brcpfcnpj.cpf_valid?(%Cpf{number: number}) do
      :ok
    else
      {:error, :invalid_cpf}
    end
  end)
end
