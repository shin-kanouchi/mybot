class ChoicesController < ApplicationController

  def new
    @tweet = Sentence.where( 'id >= ?', rand(Sentence.last.id) ).first
    @train_1 = train_adequacy_minus(docomo_reply(@tweet.sentence)) #choose_reply
    @train_2 = train_adequacy_minus(user_local_reply(@tweet.sentence))
    @train_3 = train_adequacy_minus(user_reply(current_user.id, @tweet.sentence, min_diff_score=200))
  end

  def create
    if params["train_id"] != nil
      params["train_id"].each do |t_id|
        train_adequacy_plus(1, t_id)
      end
    end
    redirect_to controller: :choices, action: :new
  end

  private
  def train_adequacy_plus(score, t_id)
      train = Train.where(id: t_id).first_or_initialize
      train.adequacy_flag = [train.adequacy_flag + score, 10].min
      train.save
  end

  def train_adequacy_minus(reply)
    train = Train.where(user_id: current_user.id, tweet_id: @tweet.id, reply_id: reply.id).first_or_initialize #.limit(1) #.last #params[:id]
    train.adequacy_flag = [train.adequacy_flag - 1, 0].max
    train.save
    return train
  end

end
