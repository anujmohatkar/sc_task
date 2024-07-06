class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    redirect_to tasks_path if current_user
  end

  def not_found
  end
end
