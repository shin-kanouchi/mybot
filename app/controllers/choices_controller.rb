class ChoicesController < ApplicationController

  def index
  end

  def new
    @tweet = Sentence.where( "topic_id = ? and bad_q_count = 0", params["topic_id"]).sample
    @train_1 = train_adequacy_minus(docomo_reply(@tweet.sentence, params["topic_id"])) #choose_reply
    @train_2 = train_adequacy_minus(user_local_reply(@tweet.sentence, params["topic_id"]))
    @train_3 = train_adequacy_minus(user_reply(current_user.id, @tweet.sentence, min_diff_score=200)) #返してないときに何かする
  end

  def update
    if params["dummy"] != ""
      tweet = Sentence.find(params["dummy"])
      tweet.bad_q_count += 1
      tweet.save
    elsif params["train_id"] != nil
      params["train_id"].each do |t_id|
        train_adequacy_plus(1, t_id)
      end
    end
    if params["id"].to_i < 10
      redirect_to controller: :choices, action: :new, id: params["id"].to_i + 1
    else
      redirect_to controller: :topics, action: :show, id: params["topic_id"]
    end
  end

  def miss_question
    
    if params["id"].to_i < 10
      redirect_to controller: :choices, action: :new, id: params["id"].to_i + 1
    else
      redirect_to controller: :topics, action: :show, id: params["topic_id"]
    end
  end

  private
  def train_adequacy_plus(score, t_id)
      train = Train.where(id: t_id).first_or_initialize
      train.adequacy_flag = [train.adequacy_flag + score, 10].min
      train.save
  end

  def train_adequacy_minus(reply)
    train = Train.where(user_id: current_user.id, tweet_id: @tweet.id, reply_id: reply.id, topic_id: params["topic_id"]).first_or_initialize #.limit(1) #.last #params[:id]
    train.choice_count += 1
    train.adequacy_flag = [train.adequacy_flag - 1, 0].max
    train.save
    return train
  end

end
