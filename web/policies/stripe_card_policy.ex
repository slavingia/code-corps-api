defmodule CodeCorps.StripeCardPolicy do
  alias CodeCorps.StripeCard
  alias CodeCorps.User

  def create?(user, card), do: user |> owns?(card)
  def delete?(user, card), do: user |> owns?(card)
  def show?(user, card), do: user |> owns?(card)

  defp owns?(%User{id: current_user_id}, %StripeCard{user_id: user_id}), do: current_user_id == user_id
end
