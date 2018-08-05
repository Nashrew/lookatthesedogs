class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def index
      render html: "Gonna turn this into a shitload of dogs"
  end
end
