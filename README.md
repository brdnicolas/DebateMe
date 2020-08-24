# 🦋 **DebateMe**



## 👨🏼‍🎨 Front

### 📦 Installation - Front

```bash
cd front/
npm install
npm run serve
```

### 🌐 Accès

Allez sûr l'url : http://localhost:8080/



## 👨🏼‍🔧 Back

### 📦 Installation - Front

Ubuntu/Debian : 
```bash
sudo apt-get install ruby-full
```

MacOS: 
```bash
brew install ruby
```


### 🚀 Deployement
Sur MacOS

1. ```bash
   brew install rbenv && rbenv init
   ```

2. ```
   rbenv install 2.5.0 && rbenv global 2.5.0
   ```

   ***Si la version sortie par `ruby -v`ne change pas suivez la 1ere solution de https://stackoverflow.com/questions/10940736/rbenv-not-changing-ruby-version***

3. ```
   rbenv install ruby-2.5.0`
   ```

4. ```
   gem install rails -v 6.0.3.1`
   ```

5. ```
   gem install bundle -v 1.17.3`
   ```

6. ```
   cd root/ 
   bundle install
   ```

   ***Il est possible qu'il y ai des problèmes car vous n'avez pas encore installer quelques gems (notamment `mysql2`) Pour installer `mysql2` : https://tinyurl.com/onMacOs ou https://tinyurl.com/andOnLinux***

   


### 🌐 Accès



1. ```bash
   rails s
   ```

2. Allez sur l'url : http://localhost:3000/

3. Pour intéragir avec la DB en CLI : 

   ```
   rails c
   ```

4. Pour lancer les TDD : 

   ```bash
   bundle exec rspec
   ```

   ou 

   ```
   bin/rspec spec
   ```

