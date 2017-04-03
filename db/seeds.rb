Subject.create(
  [
    {name: 'Science'},
    {name: 'Metal'},
    {name: 'Bad Ass'},
    {name: 'Prose'},
    {name: 'Memes'},
    {name: 'Pop'}
]
)

subjects = Subject.all

200.times do
  Question.create({ title: Faker::Hacker.say_something_smart,
                    body:  Faker::Hipster.paragraph,
                    view_count: rand(1000),
                    subject: subjects.sample
                  })
end

questions = Question.all

questions.each do |q|
  rand(0..10).times do
    q.answers.create({
        body: Faker::RickAndMorty.quote
      })
  end
end

answers_count = Answer.count

puts Cowsay.say 'Created 1000 questions', :cow

puts Cowsay.say "Created #{answers_count} answers", :ghostbusters
