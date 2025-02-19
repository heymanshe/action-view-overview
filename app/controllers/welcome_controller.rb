class WelcomeController < ApplicationController
  def index
    @name = "Himanshi"
    @people = [ "Alice", "Bob", "Charlie" ]
  end
end
