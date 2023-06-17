defmodule Adin.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication]

  authentication do
    api(Adin.Accounts)

    strategies do
      password :password do
        identity_field(:email)
        sign_in_tokens_enabled?(true)
      end
    end

    tokens do
      enabled?(true)
      token_resource(Adin.Accounts.Token)

      signing_secret("waWRr0qfV6sfabi59OizFKEzSYNJ1DhSUTkQ6H5wRYTn81NukUDI5r7zHWQ9Lgsr")
    end
  end

  # Defines convenience methods for
  # interacting with the resource programmatically.
  code_interface do
    define_for(Adin.Accounts)
    define(:create, action: :create)
    define(:read_all, action: :read)
    define(:update, action: :update)
    define(:destroy, action: :destroy)
    define(:get_by_id, args: [:id], action: :by_id)
  end

  actions do
    # Exposes default built in actions to manage the resource
    defaults([:create, :read, :update, :destroy])

    # Defines custom read action which fetches post by id.
    read :by_id do
      # This action has one argument :id of type :uuid
      argument(:id, :uuid, allow_nil?: false)
      # Tells us we expect this action to return a single result
      get?(true)
      # Filters the `:id` given in the argument
      # against the `id` of each element in the resource
      filter(expr(id == ^arg(:id)))
    end
  end

  identities do
    identity(:unique_email, [:email])
  end

  postgres do
    table("users")
    repo(Adin.Repo)
  end

  attributes do
    uuid_primary_key(:id)

    attribute :email, :ci_string do
      allow_nil?(false)
    end

    attribute :hashed_password, :string do
      sensitive?(true)
    end

    timestamps()
  end
end
