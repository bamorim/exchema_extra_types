defmodule ExchemaExtra.Types.UUIDTest do
  use ExUnit.Case
  use ExUnitProperties

  alias ExchemaExtra.Types, as: T

  property "it includes a valid generator" do
    check all version <- one_of([integer(1..1), integer(3..5), :any]),
              format <- one_of([:hex, :default, :urn, :any]),
              type <- one_of([T.UUID, constant({T.UUID, {version, format}})]),
              uuid <- ExchemaStreamData.gen(type, &ExchemaExtra.StreamData.override/2) do
      assert {:ok, _} = UUID.info(uuid)
      assert Exchema.is?(uuid, type)
      refute Exchema.is?(uuid <> "0", type)
    end
  end
end
