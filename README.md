## Comment installer Ruby

- Ubuntu/Debian : `sudo apt-get install ruby-full`
- MacOS: `brew install ruby`

## Mettre en place le projet avec Rbenv

- Sur macOS: `brew install rbenv && rbenv init`

- `rbenv install ruby-2.5.0`

- `$ gem install rails -v 6.0.3.1`

- Rentrez dans le dossier root puis : `$ bundle install`. Il est possible qu'il y ai des problèmes car vous n'avez pas encore installer quelques gems (notamment `mysql2`)
Pour installer `mysql2` : https://tinyurl.com/onMacOs ou https://tinyurl.com/andOnLinux

## Intéragir avec le projet

- Pour lancer l'API en local : `rails s`, qui lancera l'API au port 3000
- Pour intéragir avec la DB en CLI : `rails c`
- Pour lancer les TDD : `bundle exec rspec` ou `bin/rspec spec`