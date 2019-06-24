defmodule PhxQLWeb.Resolvers.CommentResolver do
  alias PhxQL.{Blog, Blog.Comment}
  alias PhxQL.Repo

  def comments(_, _, _) do
    {:ok, Blog.list_comments()}
  end

  def create_comment(_, %{input: input}, %{context: %{current_user: current_user}}) do
    comment_input = Map.merge(input, %{user_id: current_user.id})
    Blog.create_comment(comment_input)
  end

  def delete_comment(_, %{id: id}, _) do
    case Repo.get(Comment, id) do
      %Comment{} = comment ->
        Blog.delete_comment(comment)

      nil ->
        {:error, "No Comment Found!"}
    end
  end
end
