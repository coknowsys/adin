defmodule Adin.Accounts.Token do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource]

  actions do
    defaults([:destroy])
  end

  code_interface do
    define_for(Adin.Accounts)
    define(:destroy)
  end

  token do
    api(Adin.Accounts)
  end

  postgres do
    table("tokens")
    repo(Adin.Repo)
  end

  attributes do
    uuid_primary_key(:id)

    timestamps()
  end
end
