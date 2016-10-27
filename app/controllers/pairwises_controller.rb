class PairwisesController < ApplicationController

  def index
  end

  #def new
  #  @eval = Evaluate.find(params["evaluate_id"])
  #  @tweet = Sentence.where( "topic_id = ?", @eval.topic_id).sample
  #  reply_x = choose_reply(@eval.user_x_id, @tweet.sentence, @eval.topic_id)
  #  reply_y = choose_reply(@eval.user_y_id, @tweet.sentence, @eval.topic_id)
  #  @pairwise = Pairwise.create(evaluate_id: @eval.id, tweet_id: @tweet.id, reply_x_id: reply_x.id, reply_y_id: reply_y.id)
  #end

  def new
    @eval = Evaluate.find(params["evaluate_id"])
    @train_num = params["id"].to_i

    if current_user.id == @eval.user_x_id
      @tweet = Sentence.where( "topic_id = ?", @eval.topic_id).sample #ここの選び方考える
      @reply_x, @reply_y = choose_2reply(current_user.id, @tweet.sentence, @eval.topic_id)
    elsif current_user.id == @eval.user_y_id
      @tweet = Pairwise.where( "evaluate_id = ? and user_id = ?", @eval.id, @eval.user_x_id).order('created_at ASC')[@train_num-1].tweet
      @reply_x, @reply_y = choose_2reply(current_user.id, @tweet.sentence, @eval.topic_id)
    else
      pairwise_x = Pairwise.where( "evaluate_id = ? and user_id = ?", @eval.id, @eval.user_x_id).order('created_at ASC')[@train_num-1]
      pairwise_y = Pairwise.where( "evaluate_id = ? and user_id = ?", @eval.id, @eval.user_y_id).order('created_at ASC')[@train_num-1]
      @tweet = pairwise_x.tweet
      @reply_x = better_reply(pairwise_x)
      @reply_y = better_reply(pairwise_y)
    end
    @pairwise = Pairwise.create(evaluate_id: @eval.id, user_id: current_user.id, tweet_id: @tweet.id, reply_x_id: @reply_x.id, reply_y_id: @reply_y.id)
  end

  def update
    @train_num = params["id"].to_i
    pairwise = Pairwise.where( "evaluate_id = ? and user_id = ?", params["evaluate_id"], current_user.id).order('created_at ASC').last
    pairwise.inequality_flag = params["inequality_flag"]
    pairwise.save

    if @train_num < 10
      redirect_to controller: :pairwises, action: :new, id: @train_num + 1
    else
      @eval = Evaluate.find(params["evaluate_id"])
      if current_user.id == @eval.user_x_id
        num_error_first if @eval.pairwises.count != 10
        bp_operation(-1)
      elsif current_user.id == @eval.user_y_id
        num_error if Pairwise.where(evaluate_id: @eval.id, user_id: current_user.id).count != 10
        bp_operation(-1)
      else
        num_error if Pairwise.where(evaluate_id: @eval.id, user_id: current_user.id).count != 10
        @eval.win_flag = calc_win_flag
        bp_operation(2)
        calc_rank
      end
      @eval.state_flag += 1
      @eval.save
      redirect_to controller: :evaluates, action: :new
    end
  end

  #def update #evaluates/:evaluate_id/pairwises/:id
  #  pairwise = Pairwise.find(params["id"])
  #  pairwise.inequality_flag = params["inequality_flag"]
  #  pairwise.save
  #  
  #  #10問解いたら終わる
  #  @eval = Evaluate.find(params["evaluate_id"])
  #  if @eval.pairwises.count < 10
  #    redirect_to controller: :pairwises, action: :new
  #  else
  #    #勝敗計算
  #    @eval.win_flag = calc_win_flag
  #    @eval.save

  #    #評価者のバトルポイントプラス
  #    bp_operation(Bot.where('user_id = ?', current_user.id).first, 2)

  #    #被評価者のバトルポイントマイナス
  #    bp_operation(Bot.where('user_id = ?', @eval.user_x.id).first, -1)
  #    bp_operation(Bot.where('user_id = ?', @eval.user_y.id).first, -1)

  #    #rankの操作
  #    calc_rank

  #    redirect_to controller: :pairwises, action: :index
  #  end
  #end

  def num_error_first
    Pairwise.destroy_all(["evaluate_id = ?", @eval.id])
    @eval.destroy
    redirect_to controller: :tops, action: :index
  end

  def num_error
    Pairwise.destroy_all(["evaluate_id = ? and user_id = ?", @eval.id, current_user.id])
    redirect_to controller: :tops, action: :index
  end

  def better_reply(pairwise)
    if pairwise.inequality_flag = 1
      return pairwise.reply_x
    else
      return pairwise.reply_y
    end
    
  end


  def bp_operation(plus_minus)
    bot = Bot.where('user_id = ?', current_user.id).first
    bot.battle_point = [bot.battle_point + plus_minus, 0].max
    bot.save
  end

  def calc_win_flag
    scores = Pairwise.where(evaluate_id: @eval.id, user_id: current_user.id).group(:inequality_flag).order('count_inequality_flag DESC').limit(3).count(:inequality_flag)
    #scores = @eval.pairwises.group(:inequality_flag).order('count_inequality_flag DESC').limit(3).count(:inequality_flag)
    x_score = 0
    y_score = 0
    x_score += scores[1] if scores.has_key?(1)
    y_score += scores[2] if scores.has_key?(2)

    if x_score > y_score
      return 1
    elsif x_score < y_score
      return 2
    else
      return 0
    end
  end

  def calc_rank
    bot_x = Bot.where(user_id: @eval.user_x_id).first
    bot_y = Bot.where(user_id: @eval.user_y_id).first
    if @eval.win_flag == 1
      bot_x.bot_rank += 2 * rank_margin(bot_x.bot_rank)
      bot_y.bot_rank -= 10
    elsif @eval.win_flag == 2
      bot_x.bot_rank -= 10
      bot_y.bot_rank += 2 * rank_margin(bot_y.bot_rank)
    else
      bot_x.bot_rank += rank_margin(bot_x.bot_rank)
      bot_y.bot_rank += rank_margin(bot_y.bot_rank)
    end
    bot_x.save
    bot_y.save
  end

  def rank_margin(rank)
    #d:~200, c:~400, b:~600, a:~800, s:~1000 ss:1000~
    if rank < 200
      return 16
    elsif rank < 400
      return 12
    elsif rank < 600
      return 8
    elsif rank < 800
      return 6
    elsif rank < 1000
      return 5
    else
      return 4
    end
  end 
end
