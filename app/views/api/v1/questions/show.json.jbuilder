json.id @question.id
json.title @question.title.titleize
json.created_at @question.created_at.strftime('%Y-%B-%D')
json.body @question.body
json.answers @question.answers do |answer|
  json.id answer.id
  json.body answer.body
end
