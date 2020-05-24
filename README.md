## Comment installer Ruby

- Ubuntu/Debian : `sudo apt-get install ruby-full`
- MacOS: `brew install ruby`

## Mettre en place le projet avec Rbenv

- Sur macOS: `$ brew install rbenv && rbenv init`

- `$ rbenv install 2.5.0 && rbenv global 2.5.0`. Si la version sortie par `ruby -v`ne change pas suivez la 1ere solution de https://stackoverflow.com/questions/10940736/rbenv-not-changing-ruby-version  
- `$ rbenv install ruby-2.5.0`
- `$ gem install rails -v 6.0.3.1`
- `$ gem install bundle -v 1.17.3`

- Rentrez dans le dossier root puis : `$ bundle install`. Il est possible qu'il y ai des problèmes car vous n'avez pas encore installer quelques gems (notamment `mysql2`)
Pour installer `mysql2` : https://tinyurl.com/onMacOs ou https://tinyurl.com/andOnLinux

## Intéragir avec le projet

- Pour lancer l'API en local : `rails s`, qui lancera l'API au port 3000
- Pour intéragir avec la DB en CLI : `rails c`
- Pour lancer les TDD : `bundle exec rspec` ou `bin/rspec spec`