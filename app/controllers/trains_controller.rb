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
    @reply, @min_diff_score = choose_reply
    @train = train_adequacy_plus
    logger.debug("Hello, world!")
  end

  def update
    _train = train_adequacy_minus
    @tweet = _train.tweet
    @reply = Sentence.where(sentence: params["tweet"]).first_or_create
    @train = train_adequacy_plus
  end

  private
  def train_params
    params.require(:train).permit(:reply_id).merge(adequacy_flag: 1)
  end

  def train_adequacy_plus
      train = Train.where(user_id: current_user.id, tweet_id: @tweet.id, reply_id: @reply.id).first_or_initialize
      train.adequacy_flag = [train.adequacy_flag + 1, 10].min
      train.save
  end

  def train_adequacy_minus
    train = Train.order("updated_at DESC").first #.limit(1) #.last #params[:id]
    train.adequacy_flag = [train.adequacy_flag - 1, 0].max
    train.save
    return train
  end

  def choose_reply
    min_diff_score = 30
    reply = nil
    Train.where(user_id: current_user.id, adequacy_flag: 1..10).each do |train|
      lev = Levenshtein.distance(@tweet.sentence, train.tweet.sentence)
      diff_score = 100 * lev / train.tweet.sentence.length
      if diff_score < min_diff_score
        reply = train.reply
        min_diff_score = diff_score
      end
    end
    if reply.blank?
      reply = docomo_reply
    end
    return reply, min_diff_score
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
