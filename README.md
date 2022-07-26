# facturacion
First tries with phoenix framework using docker.

To create app with the name facturacion:

dcr => docker-compose run

* dcr --rm app mix phx.new . --app facturacion --database sqlite3

All setup for code hygene taken from: 
https://experimentingwithcode.com/code-hygiene-with-elixir-part-1/
https://experimentingwithcode.com/code-hygiene-with-elixir-part-2/

Credo:

* dcr --rm app mix credo --strict

Coveralls:

* dcr --rm app mix coveralls

if you want part of your code to skip the coveralls:

'# coveralls-ignore-start'
'code..'
'# coveralls-ignore-stop'

Boundary:

* dcr --rm app mix clean
* dcr --rm app mix compile --warning-as-errors

Exdoc:
* dcr --rm app mix docs
* open ./src/doc/index.html

GitHooks:
* dcr --rm app mix git_hooks.run pre_commit
* dcr --rm app mix git_hooks.run pre_push
