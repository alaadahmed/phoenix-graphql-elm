defmodule PhxQLWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias PhxQLWeb.Schema.Types

  import_types(Types.UserType)
  import_types(Types.SessionType)
end
