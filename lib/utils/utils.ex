defmodule SubscriptionBackend.Utils do

  alias SubscriptionBackend.DomainsBlackList

  def handle_changeset_errors(errors) do
    Enum.map(errors, fn {field, detail} ->
      %{"#{field}": render_detail(detail)}
    end)

  end

  def render_detail({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end

  def render_detail(message) do
    message
  end

end
