class ChoicesController < ApplicationController

  def index
  end

  def new
    @tweet = Train.where("user_id = ? and topic_id = ?", User.first.id, params["topic_id"]).order("choice_count ASC").limit(500).sample.tweet
    my_train = adequacy_minus(user_train(current_user.id, @tweet.sentence, min_diff_score=200))
    @trains = Train.where("user_id = ? and tweet_id = ?", User.first.id, @tweet.id).order("choice_count ASC").limit(5).sample(3)
    @trains = save_for_my_trains(@trains, my_train)
    @trains.push(my_train)
    @trains.shuffle
  end

  #def new
  #  @tweet = Sentence.where( "topic_id = ? and bad_q_count = 0", params["topic_id"]).sample
  #  @train_1 = train_adequacy_minus(docomo_reply(@tweet.sentence, params["topic_id"])) #choose_reply
  #  @train_2 = train_adequacy_minus(user_local_reply(@tweet.sentence, params["topic_id"]))
  #  @train_3 = train_adequacy_minus(user_reply(current_user.id, @tweet.sentence, min_diff_score=200)) #返してないときに何かする
  #end

  def update
    if params["dummy"] != ""
      tweet = Sentence.find(params["dummy"])
      tweet.bad_q_count += 1
      tweet.save
    elsif params["train_id"] != nil
      params["train_id"].each do |t_id|
        train_adequacy_plus(2, t_id)
      end
    end
    if params["id"].to_i < 10
      redirect_to controller: :choices, action: :new, id: params["id"].to_i + 1
    else
      redirect_to controller: :topics, action: :show, id: params["topic_id"]
    end
  end

  def miss_question
  end

  private
  def train_adequacy_plus(score, t_id)
    train = Train.where(id: t_id).first_or_initialize
    train.adequacy_flag = [train.adequacy_flag + score, 20].min
    train.save

    master_train = Train.where(user_id: User.first.id, tweet_id: train.tweet_id, reply_id: train.reply_id, topic_id: train.topic_id).first_or_initialize
    master_train.adequacy_flag = [train.adequacy_flag + score, 20].min
    master_train.save
  end

  def adequacy_minus(train)
    train.choice_count += 1
    train.adequacy_flag = [train.adequacy_flag - 1, 0].max
    train.save
    return train
  end

  def save_for_my_trains(trains, my_train)
    new_trains = []
    trains.each do |train|
      train = adequacy_minus(train)

      new_train = Train.where(user_id: current_user.id, tweet_id: @tweet.id, reply_id: train.reply_id, topic_id: train.topic_id).first_or_initialize
      if new_train.id != my_train.id
        new_train = adequacy_minus(new_train)
        new_trains.push(new_train)
      end
    end
    return new_trains
  end

end
