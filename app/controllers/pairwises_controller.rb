class PairwisesController < ApplicationController

  def index
  end

  def new
    @eval = Evaluate.find(params["evaluate_id"])
    @tweet = Sentence.where( 'id >= ?', rand(Sentence.last.id)).first #最近学習していないもので，という条件を付ける
    reply_x = choose_reply(@eval.user_x_id, @tweet.sentence)
    reply_y = choose_reply(@eval.user_y_id, @tweet.sentence)
    @pairwise = Pairwise.create(evaluate_id: @eval.id, tweet_id: @tweet.id, reply_x_id: reply_x.id, reply_y_id: reply_y.id)
  end

  def update #evaluates/:evaluate_id/pairwises/:id
    pairwise = Pairwise.find(params["id"])
    pairwise.inequality_flag = params["inequality_flag"]
    pairwise.save
    
    #10問解いたら終わる
    @eval = Evaluate.find(params["evaluate_id"])
    if @eval.pairwises.count < 10
      redirect_to controller: :pairwises, action: :new
    else
      @eval.win_flag = @eval.pairwises.group(:inequality_flag).order('count_inequality_flag DESC').limit(1).count(:inequality_flag).keys[0]
      @eval.save
      bot = Bot.where('user_id = ?', current_user.id).first
      bot.battle_point += 1
      bot.save
      redirect_to controller: :pairwises, action: :index
    end
  end

end
