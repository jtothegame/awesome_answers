Rails.application.routes.draw do

  # When we receive a "GET" request with URL '/about', then Rails will invoke the 'about_controller' with 'index' action.
  # Action is just a method that is defined within a controller.
  get('/about', { to: 'about#index' })
  # is the same as below, just written without the brackets.
  # get('/about' to: 'about#index'
  # you can also write it as:
  # get('/about' => 'about#index')

  # If you don't pass an 'as:' option then Rails will attempt to generate a URL / PATH helper for you.
  # If you pass the 'as:' option then Rails will use that as the URL/PATH helper. The auto-generated path helper will be 'contact_us_path' while after we added the 'as:' option, it will just be 'contact_path'

  get('/contact_us', { to: 'contact#new', as: 'contact' })
  post('/contact', { to: 'contact#create', as: 'contact_submit'})

  resources :questions do
    resources :answers, only: [:create, :destroy]

    # Nesting resources :answers, only: [:create, :destroy] in resources :questions
    # will create the following routes:

    # Prefix Verb   URI Pattern                                   Controller#Action
    # question_answers POST   /questions/:question_id/answers(.:format)     answers#create
    # question_answer DELETE /questions/:question_id/answers/:id(.:format) answers#destroy

    # When using their helper methods to generate the path to the routes (e.g. question_answers_path)
    # make sure to include a question_id as argument or a question model
  end

  # get('/questions/new', { to: 'questions#new', as: 'new_question' })
  # post('/questions', { to: 'questions#create', as: 'questions' })
  #
  # # The order of the URL matters because Rails gives a higher priority for routes that appear first.
  # get('/questions/:id', { to: 'questions#show', as: 'question' })
  #
  # # Note that we don't need to pu 'as:' option in here because we used the same URL for the 'create' action. Indeed Rails will throw an error if you try to reuse a predefined path helper.
  # # Remember that the 'as:' option defines a path/url helper which only generates a URL and isn't concerned about the VERB.
  # get('/questions/', { to: 'questions#index' })
  #
  # get('/questions/:id/edit', { to: 'questions#edit', as: 'edit_question' })
  #
  # patch('/questions/:id', { to: 'questions#update' })
  #
  # # the VERB is delete but the action is called 'destroy'
  # delete('/questions/:id', {to: 'questions#destroy' })

  # This will make the home page of the application go to WelcomeController with index action.
  root 'welcome#index'
end
