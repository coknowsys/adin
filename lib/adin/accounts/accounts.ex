defmodule Adin.Accounts do
  use Ash.Api

  resources do
    registry Adin.Accounts.Registry
  end
end
