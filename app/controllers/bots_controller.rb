class BotsController < ApplicationController

  def new
  end

  def create
    Bot.create(bot_name: bot_params[:bot_name], hair_color: bot_params[:hair_color], gender: bot_params[:gender], user_id: current_user.id) #: bot_params[:hair_color]
    Train.create(user_id: current_user.id, tweet_id: Sentence.first.id, reply_id: Sentence.first.id, adequacy_flag: 1) #ここエラーの元になりそう
    Train.create(user_id: current_user.id, tweet_id: Sentence.second.id, reply_id: Sentence.first.id, adequacy_flag: 1)
    redirect_to controller: :tops, action: :index
  end

  def edit
    @bot = Bot.find(params[:id])
  end

  def update
    bot = Bot.find(params[:id])
    if bot.user_id == current_user.id
      bot.update(bot_params)
    end
  end

  def destroy
    bot = Bot.find(params[:id])
    bot.destroy if bot.user_id == current_user.id
  end

  private
  def bot_params
    params.permit(:bot_name, :hair_color, :gender) #:character_flag. :hair_color
  end

end
