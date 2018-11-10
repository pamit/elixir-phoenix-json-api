defmodule BusiApiWeb.UserView do
  use BusiApiWeb, :view

  def render("user.json", %{user: user, token: token}) do
    %{
      email: user.email,
      token: token
    }
  end
end
