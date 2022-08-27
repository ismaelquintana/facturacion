# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Facturacion.Repo.insert!(%Facturacion.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Facturacion.Clientes.Cliente
alias Facturacion.Repo

for id <- 1..1000 do
  Repo.insert!(%Cliente{
    id: id,
    direccion: Faker.Address.Es.street_address() <> ", " <> Faker.Address.Es.city(),
    name: Faker.Company.name(),
    cif: Faker.Util.format("%8d%A")
  })
end
