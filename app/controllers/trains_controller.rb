class TrainsController < ApplicationController
  def index
    @trains = Train.all
  end

  def new
    #@sentence = Sentence.where( 'id >= ?', rand(Sentence.count)*10 - 8 ).first
    @sentence = Sentence.where( 'id >= ?', rand(Sentence.count) + 1 ).first
  end

  def create
    @tweet = Sentence.where(sentence: params["tweet"], source_flag: 0).first_or_create
    logger.debug(@tweet)
    @reply = choose_reply(current_user.id, @tweet.sentence)
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
      @train.adequacy_flag = [@train.adequacy_flag + score, 10].min
      @train.save
  end
end
