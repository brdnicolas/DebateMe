# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

achievements = [
  {
    name: 'Homme mystère',
    description: 'Alors comme ça on ne veux parler sans son nom ?',
    goal: 'Faire un post en Anonyme'
  },
  {
    name: 'Validé',
    description: 'Vous êtes officiellement validé par DebateMe',
    goal: 'Remplir toutes les informations de son profil'
  },
  {
    name: 'Premier pas',
    description: "On place d'abord sa souris dans le champs de saisie, et ensuite seulement on argumente !",
    goal: 'Répondre à une question'
  },
  {
    name: 'Symphatique',
    description: "Il faut croire que les gens sont d'accord avec vous !",
    goal: 'Avoir 100 up au total sous ses posts'
  },
  {
    name: 'Influenceur',
    description: "L'avis des gens est important, oui, mais le vôtre un peu plus",
    goal: 'Avoir 15 sous commentaires sur un posts'
  }
]

pics = %w[anonymous.png tick.png foot.png heart.png influence.png]
i = 0
achievements.each do |achievement|
  a = Achievement.create(achievement)
  a.badge.attach(io: File.open("public/logo_achievements/#{pics[i]}"), filename: pics[i])
  i += 1
end

50.times do
  user = User.create(email: Faker::Internet.email, password: 'qwerty')
  UserInfo.create(username: Faker::Internet.username,
                  firstname: Faker::Name.first_name,
                  lastname: Faker::Name.last_name,
                  quote: Faker::Lorem.sentence,
                  user_id: user.id)

  print'.'
end
User.create!(email: 'admin@hugovast.tech',
             password: 'admin',
             isAdmin: true)
UserInfo.create!(user_id: User.last.id, firstname: 'admin', lastname: 'admin', username: 'admin')
@users = User.all

themes = %w[Science Écologie Politique Actualité Sports Musique Tech Gaming]
themes_pic = %w[sciences.png earth.png democracy.png news.png gym.png music.png lightning.png games.png]
puts "\n#{@users.size} users created"
themes.each_with_index do |theme, i|
  Theme.create!(name: theme)
  puts "public/logo_themes/#{themes_pic[i]}"
  Theme.last.logo.attach(io: File.open("public/logo_themes/#{themes_pic[i]}"), filename: themes_pic[i])
  print '.'
end
@themes = Theme.all

puts "\n#{@themes.size} themes created"

@themes.each do |theme|
  5.times do
    theme.questions.create!(title: Faker::Lorem.question,
                            documentation: Faker::Lorem.paragraphs,
                            start_time: '2020-05-23 16:15:40',
                            end_time: '2020-05-23 17:15:40')
    print '.'
  end
  print ' x '
end
puts "\n #{Question.count} questions created"
Question.all.each do |question|
  10.times do

    question.posts.create!(content: Faker::Lorem.paragraphs,
                           isAnonym: (true if rand > 0.8),
                           up: Integer(rand * 10),
                           down: Integer(rand * 10),
                           user_id: @users.sample.id,
                           subpost_id: (question.posts.sample&.id if rand > 0.8))
    print '.'
  end
  print '|'
end
puts "\n #{Post.count} fake answer created"

reasons_str = ['Ce contenu est injurieux',
               "Ce contenu n'as pas sa place ici",
               'Les propos devraient être reformulés',
               'Ce contenu tiens des propos racistes',
               'Ce contenu tiens des propos sexistes']

reasons_str.each { |reason| ReasonReport.create!(reason: reason) }

# ECOLOGIE

theme = Theme.find_by_name('Écologie')
theme.questions.destroy_all

questions = [
  {
    title: "Doit-on renoncer à l'énergie nucléaire ?",
    documentation: "Dans le langage courant, l'énergie nucléaire correspond aux usages civils et militaires de l'énergie libérée lors des réactions de fission nucléaire des noyaux atomiques au sein d'un réacteur nucléaire ou lors d'une explosion atomique (dans le cas d'une bombe thermonucléaire il existe aussi des réactions de fusion nucléaire).",
    start_time: '2020-07-23 00:00:00',
    end_time: '2020-07-30 00:00:00'
  },
  {
    title: 'Faut-il exploiter le gaz de schiste ?',
    documentation: "Les problèmes environnementaux associés à l'extraction du gaz de schiste, notamment l'utilisation intensive et la pollution des réserves d'eau, l'augmentation des tremblements de terre ainsi que l'émission de gaz à effet de serre, entraînent dans certains pays, y compris aux États-Unis, une défiance de l'opinion publique. Le sujet fait l'objet de controverses très vives qui opposent d'une part ceux qui voient dans la mise en exploitation de cette ressource de gaz non conventionnel un moyen de diminuer les importations énergétiques et d'augmenter les revenus du pays ainsi que les industriels du secteur pétrolier et d'autre part différents mouvements mettant en avant des arguments écologiques.",
    start_time: '2020-07-16 00:00:00',
    end_time: '2020-07-23 00:00:00'
  },
  {
    title: "La ruralité est-elle un modèle d'avenir ?",
    documentation: "La ruralité « fait référence à l'ensemble des représentations collectives associées à la vie dans les espaces ruraux. Proche de l'idée de mode de vie, le mot est apparu à la fin des années 1990 pour désigner un lien, dans sa dimension anthropologique, aux différents contenus de l'espace rural (de moins en moins agricole mais plus tourné sur l'environnement, le patrimoine et les paysages). Devenue une notion globalisante pour désigner un mode d'habiter (Mathieu, 1996) qui permet d'atténuer une opposition franche entre la ville et la campagne devenue obsolète. On notera cependant qu'une dimension politique tend aujourd'hui à rattraper le terme, et impose d'y apporter un regard critique, tant le monde politique et la presse l'utilise de plus en plus fréquemment (« assises de la ruralité », « hyper-ruralité », défense de la ruralité…). »",
    start_time: '2020-07-09 00:00:00',
    end_time: '2020-07-16 00:00:00'
  },
  {
    title: "Nos ressources d'eau sont elle menacées ?",
    documentation: 'https://www.cieau.com/connaitre-leau/les-ressources-en-france-et-dans-le-monde/ou-en-sont-les-ressources-en-eau-dans-le-monde/',
    start_time: '2020-07-02 00:00:00',
    end_time: '2020-07-09 00:00:00'
  },
  {
    title: 'Doit-on renforcer la réglementation sur la responsabilité collective ?',
    documentation: 'https://www.cairn.info/revue-francaise-de-science-politique-2008-6-page-899.htm#',
    start_time: '2020-06-26 00:00:00',
    end_time: '2020-07-02 00:00:00'
  }
]

questions_pictures = %w[nuclear.jpg shiste.jpeg rural.jpeg water.jpeg collectif.jpg]


questions.each_with_index do |q, i|
  Question.create!(q.merge(theme_id: theme.id))
  puts "public/questions/ecologie/#{questions_pictures[i]}"
  Question.last.image.attach(io: File.open("public/questions/ecologie/#{questions_pictures[i]}"), filename: questions_pictures[i])
  print '.'
end
# SPORT

theme = Theme.find_by_name('Sports')
theme.questions.destroy_all


questions = [
  {
    title: 'Doit on revoir la gestion du dopage dans le sport ?',
    documentation: 'https://fr.wikipedia.org/wiki/Dopage_(sport)',
    start_time: '2020-07-23 00:00:00',
    end_time: '2020-07-30 00:00:00'
  },
  {
    title: 'La corruption est-elle omniprésente dans le football professionnel ?',
    documentation: "La Convention du Conseil de l'Europe sur la manipulation de compétitions sportives (2014) défini un la manipulation des sports compétitifs comme: « Un arrangement, un acte ou une omission intentionnels visant à une modification irrégulière du résultat ou du déroulement d’une compétition sportive afin de supprimer tout ou partie du caractère imprévisible de cette compétition, en vue d’obtenir un avantage indu pour soi-même ou pour autrui. ». La définition comprend donc les tentatives de modification du déroulement d'un événement (appelées « trucage d'action ») ainsi que le résultat général. Le trucage de match est également concerné à la fois pour des raisons sportives et financières.",
    start_time: '2020-07-16 00:00:00',
    end_time: '2020-07-23 00:00:00'
  },
  {
    title: 'Le tour de france doit-il se passer de spectateurs ?',
    documentation: '',
    start_time: '2020-07-09 00:00:00',
    end_time: '2020-07-16 00:00:00'
  },
  {
    title: 'Doit-on plafonner le salaire des sportifs ?',
    documentation: 'https://www.forbes.fr/classements/sports/lionel-messi-en-premiere-place-du-classement-des-sportifs-les-mieux-payes-du-monde/',
    start_time: '2020-07-02 00:00:00',
    end_time: '2020-07-09 00:00:00'
  },
  {
    title: "Les budgets de club ruine-t'il le fairplay sportif ?",
    documentation: 'https://fr.uefa.com/community/news/newsid=2065498.html',
    start_time: '2020-06-26 00:00:00',
    end_time: '2020-07-02 00:00:00'
  }
]

questions_pictures = %w[dopage.jpg corruption.png tourdefrance.jpg argentfoot.jpg faitplay.jpg]

questions.each_with_index do |q, i|
  Question.create!(q.merge(theme_id: theme.id))
  puts "public/questions/sport/#{questions_pictures[i]}"
  Question.last.image.attach(io: File.open("public/questions/sport/#{questions_pictures[i]}"), filename: questions_pictures[i])
  print '.'
end


