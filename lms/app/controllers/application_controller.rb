class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def show
    render html: "Father of five"
  end
end
