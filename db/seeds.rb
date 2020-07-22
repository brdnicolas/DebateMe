# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
50.times do
  user = User.create(email: Faker::Internet.email, password: 'qwerty')
  UserInfo.create(username: Faker::Internet.username,
                   firstname: Faker::Name.first_name,
                   lastname: Faker::Name.last_name,
                   quote: Faker::Lorem.sentence,
                   user_id: user.id
                   )

  print'.'
end
User.create!( email: 'admin@hugovast.tech',
              password: 'admin',
              isAdmin: true
)
UserInfo.create!(user_id: User.last.id, firstname: 'admin', lastname: 'admin', username: 'admin')
@users = User.all

puts "\n#{@users.size} users created"
5.times do
  Theme.create!(name: Faker::Lorem.question)
  print '.'
end
@themes = Theme.all
puts "\n#{@themes.size} themes created"

@themes.each do |theme|
  5.times do
    theme.questions.create!( title: Faker::Lorem.question,
                             documentation: Faker::Lorem.paragraphs,
                             start_time: "2020-05-23 16:15:40",
                             end_time: "2020-05-23 17:15:40")
    print '.'
  end
  print '|'
end
puts "\n #{Question.count} questions created"
Question.all.each do |question|
  10.times do

    question.posts.create!( content: Faker::Lorem.paragraphs,
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

reasons_str = ["Ce contenu est injurieux",
               "Ce contenu n'as pas sa place ici",
               "Les propos devraient être reformulés",
               "Ce contenu tiens des propos racistes",
               "Ce contenu tiens des propos sexistes"]

reasons_str.each { |reason| ReasonReport.create!(reason: reason) }

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
achievements.each { |achievement| Achievement.create(achievement) }