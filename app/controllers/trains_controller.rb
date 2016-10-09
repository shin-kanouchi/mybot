class TrainsController < ApplicationController
  def index
    #@tweet = Question.find(params[:question_id])
    #@answers  = Answer.where(question_id: params[:question_id]).limit(4)
    #@trains   = Train.all
    @trains = Train.all
  end

  def new
    @train = Train.find(1)
    @sentence = Sentence.where( 'id >= ?', rand(Sentence.count) + 1 ).first
  end

  def create
    @tweet = create_sentence
    @reply = docomo_reply
    @train = Train.create(tweet_id: @tweet.id, reply_id: @reply.id, adequacy_flag: 1)
  end

  def update
    @reply = create_sentence
    train = Train.last #params[:id]
    train.update(adequacy_flag: 0) #train_idを受け取ってない
    @train = Train.create(tweet_id: train.tweet_id, reply_id: @reply.id, adequacy_flag: 1)
  end

  private
  def train_params
    params.require(:train).permit(:reply_id).merge(adequacy_flag: 1)
  end

  def docomo_reply
    client = Docomoru::Client.new(api_key: '6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')
    while true
      reply = client.create_dialogue(params["tweet"]).body["utt"]
      if reply.length < 40
        break
      end
    end
    Sentence.where(sentence: reply).first_or_create
  end

  def create_sentence
    Sentence.where(sentence: params["tweet"]).first_or_create
  end
end
