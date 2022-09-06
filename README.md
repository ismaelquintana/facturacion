# facturacion
First tries with phoenix framework using docker.


>dcr => docker-compose run

1. To create app with the name facturacion:

- dcr --rm app mix phx.new . --app facturacion --database sqlite3

>All setup for code hygene taken from: 
>https://experimentingwithcode.com/code-hygiene-with-elixir-part-1/
>https://experimentingwithcode.com/code-hygiene-with-elixir-part-2/

2. Credo:

- dcr --rm app mix credo --strict

3. Coveralls:

- dcr --rm app mix coveralls

>if you want part of your code to skip the coveralls:

>'# coveralls-ignore-start'
>'code..'
>'# coveralls-ignore-stop'

4. Boundary:

- dcr --rm app mix clean
- dcr --rm app mix compile --warning-as-errors

5. Exdoc:
- dcr --rm app mix docs
- open ./src/doc/index.html

6. GitHooks:
- dcr --rm app mix git_hooks.run pre_commit
- dcr --rm app mix git_hooks.run pre_push

---
Sometimes you might have problems when doing `git commit`, if so do:
- rm -rf ./hooks
- dcr --rm app mix git_hooks.install

---
Other commands could be useful to include taken from:
https://curiosum.com/blog/mastering-elixir-ci-pipeline?utm_medium=email&utm_source=elixir-radar

- dcr --rm app mix hex.audit
- dcr --rm app mix deps.unlock --check-unused
- dcr --rm app mix deps.audit ---> should be install
- dcr --rm app mix format --dry-run --check-formatted
- dcr --rm app mix compile --all-warnings --warning-as-errors
- dcr --rm app mix ecto.create && mix ecto.migrate && mix ecto.rollback --all
- dcr --rm app mix sobelow
- dcr --rm app mix doctor

----
Install tailwindcss:

https://tailwindcss.com/docs/guides/phoenix

---

Create an export csv controller:

https://fullstackphoenix.com/tutorials/csv-export

Pagination and order table:

https://fullstackphoenix.com/tutorials/building-a-datatable-in-phoenix-liveview
