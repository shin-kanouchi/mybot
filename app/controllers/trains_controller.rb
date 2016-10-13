class TrainsController < ApplicationController
  def index
    @trains = Train.all
  end

  def new
    @train = Train.find(1) #このままだとはじめにエラーが出るので注意
    @sentence = Sentence.where( 'id >= ?', rand(Sentence.count) + 1 ).first
  end

  def create
    @tweet = Sentence.where(sentence: params["tweet"]).first_or_create
    @reply = choose_reply
    if @reply.blank?
      @reply = docomo_reply
    end
    train_adequacy_plus(1)
  end

  def update
    #修正前の候補を減点
    train = Train.find(params["id"])
    train.adequacy_flag = [train.adequacy_flag - 3, 0].max
    train.save

    #修正後の応答に加点
    @tweet = train.tweet
    @reply = Sentence.where(sentence: params["tweet"]).first_or_create
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

  def choose_reply
    min_diff_score = 30
    reply = nil
    Train.where(user_id: current_user.id, adequacy_flag: 1..10).each do |train|
      lev = Levenshtein.distance(@tweet.sentence, train.tweet.sentence)
      diff_score = 100 * lev / (train.tweet.sentence.length + 1)
      if diff_score < min_diff_score
        reply = train.reply
        min_diff_score = diff_score
      end
    end
    return reply
  end

  def docomo_reply
    client = Docomoru::Client.new(api_key: '6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')
    while true
      reply = client.create_dialogue(@tweet.sentence).body["utt"]
      if reply.length < 30
        break
      end
    end
    Sentence.where(sentence: reply).first_or_create
  end
end
