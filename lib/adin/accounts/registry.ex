defmodule Adin.Accounts.Registry do
  use Ash.Registry,
    extensions: Ash.Registry.ResourceValidations

  entries do
    entry(Adin.Accounts.User)
    entry(Adin.Accounts.Token)
  end
end
