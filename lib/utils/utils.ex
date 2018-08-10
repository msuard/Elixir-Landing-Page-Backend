defmodule SubscriptionBackend.Utils do

  alias SubscriptionBackend.DomainsBlackList

  def validate_email(email) when is_binary(email) do
    case Regex.run(~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, email) do
      nil ->
        {:error, "Invalid email"}
      [email] ->
        case Regex.run(~r/(\w+)@([\w.]+)/, email) do
          nil -> {:error, "Invalid email"}
          _ -> {:ok, "Valid email"}
        end
    end
  end

  def validate_domain(email) when is_binary(email) do

    domain =
      String.split(email, "@")
      |> Enum.at(-1)
      |> String.split(".")
      |> Enum.drop(-1)
      |> Enum.join(".")

    if domain in DomainsBlackList.domainsBlackList do
      {:error, "Invalid domain"}
    else
      {:ok, "Valid domain"}
    end

  end
end
