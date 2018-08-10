# SubscriptionBackend

Backend service for the Novamining ICO landing page.

To start your Phoenix server on http://localhost:4000 :

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Endpoints:

POST /subscribe/new : inserts a new subscriber into database

    Payload:

        {
            first_name: string,
            last_name: string,
            email: string
        }
        
GET /subscribe/health : health endpoint, returns current timestamp
