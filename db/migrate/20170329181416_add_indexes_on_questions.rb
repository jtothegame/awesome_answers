class AddIndexesOnQuestions < ActiveRecord::Migration[5.0]
  def change
    add_index :questions, :title
    add_index :questions, :body

    # to create a composite index you can do:
    # add_index :question, [:title, :body]
    # the above composite index is good if most of your queries include both searching on the title and body.
  end
end
