# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BusiApi.Repo.insert!(%BusiApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BusiApi.Repo
alias BusiApi.Directory.Business

Repo.insert! %Business{name: "Company 1", description: "Short description ...", tag: "IT, Software"}
Repo.insert! %Business{name: "Company 2", description: "Short description ...", tag: "Marketing"}
Repo.insert! %Business{name: "Company 3", description: "Short description ...", tag: "Accounting"}
