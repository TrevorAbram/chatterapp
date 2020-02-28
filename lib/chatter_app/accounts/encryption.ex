defmodule ChatterApp.Accounts.Encryption do
  alias ChatterApp.Accounts.User
  alias Comeonin.Bcrypt

  def hash_password(password) do: Bcrypt.hashpwsalt(password)

  # NOTE: if def have "do:" the end is not necessary
  def validate_password(%User{} = user, password), do: Bcrypt.check_pass(user, password)




end
