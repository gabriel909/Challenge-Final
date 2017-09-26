class WelcomeController < ApplicationController
  def index
    render html: "<h1>Ola</h1>"
  end
end
