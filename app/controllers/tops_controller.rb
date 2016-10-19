class TopsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def ranking
    @bots = Bot.order('bot_rank DESC').limit(10)
  end


end
