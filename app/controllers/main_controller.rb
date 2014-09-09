class MainController < ApplicationController
  def index
  end

  def templates
    render partial: "#{params[:template]}"
  end
end
