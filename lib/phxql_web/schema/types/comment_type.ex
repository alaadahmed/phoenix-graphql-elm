defmodule PhxQLWeb.Schema.Types.CommentType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias PhxQL.{Accounts, Blog}
  alias PhxQL.Accounts.User
  alias PhxQL.Blog.Post

  object :comment_type do
    field(:id, :id)
    field(:content, :string)
    field(:user, :user_type, resolve: dataloader(User))
    field(:post, :post_type, resolve: dataloader(Post))
  end

  input_object :comment_input_type do
    field(:content, non_null(:string))
    field(:post_id, non_null(:id))
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Blog, Blog.datasource())
      |> Dataloader.add_source(Accounts, Accounts.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
