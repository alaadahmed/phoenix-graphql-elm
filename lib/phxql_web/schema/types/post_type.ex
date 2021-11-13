defmodule PhxQLWeb.Schema.Types.PostType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias PhxQL.Accounts

  object :post_type do
    field(:id, :id)
    field(:title, :string)
    field(:content, :string)
    field(:published, :boolean)
    field(:user, :user_type, resolve: dataloader(User))
  end

  input_object :post_input_type do
    field(:title, non_null(:string))
    field(:content, non_null(:string))
    field(:published, non_null(:boolean))
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
