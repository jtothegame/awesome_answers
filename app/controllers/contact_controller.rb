class ContactController < ApplicationController

  def new

  end

  def create
    # If you want to define a variable that you can access in the view file then you will need to define the variable as an instance variable as in:
    @name = params[:name] # you can access inside the view file
    # such as: create.html.erb

    # This will render a plain text response that has a body of 'Thank you for contacting us!'
    render plain: "Thank you #{params[:name]} for contacting us!"
  end

end
