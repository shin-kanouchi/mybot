class TrainsController < ApplicationController

  def new
    @sentence = Train.where("user_id = ?", User.first.id).sample.tweet
  end

  def create
    @tweet = Sentence.where(sentence: params["tweet"], source_flag: 0).first_or_create
    save_b2u
    @reply = user_train(current_user.id, @tweet.sentence).reply
    train_adequacy_plus(1)
  end

  def update
    #修正前の候補を減点
    train = Train.find(params["id"])
    train.adequacy_flag = [train.adequacy_flag - 3, 0].max
    train.save

    #修正後の応答に加点
    @tweet = train.tweet
    @reply = Sentence.where(sentence: params["tweet"], source_flag: 0).first_or_create
    train_adequacy_plus(3)

  end

  private
  #def train_params
  #  params.require(:train).permit(:reply_id).merge(adequacy_flag: 1)
  #end

  def train_adequacy_plus(score)
      @train = Train.where(user_id: current_user.id, tweet_id: @tweet.id, reply_id: @reply.id).first_or_initialize
      @train.free_u2b_count += 1
      @train.adequacy_flag = [@train.adequacy_flag + score, 10].min
      @train.save
  end

  def save_b2u
    train_b2u = Train.where(user_id: current_user.id, tweet_id: params["old_reply_id"], reply_id: @tweet.id).first_or_initialize
    train_b2u.free_b2u_count += 1
    train_b2u.adequacy_flag += 3
    train_b2u.save
  end

end
