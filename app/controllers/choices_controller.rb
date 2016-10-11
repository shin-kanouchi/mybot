class ChoicesController < ApplicationController

  def new
    @tweet = Sentence.where( 'id >= ?', rand(Sentence.count) + 1 ).first
    @train_1 = train_adequacy_minus(docomo_reply) #choose_reply
    @train_2 = train_adequacy_minus(docomo_reply)
    @train_3 = train_adequacy_minus(docomo_reply)
  end

  def update
    train_adequacy_plus(1)
    redirect_to controller: :choices, action: :new
  end

  private
  def train_adequacy_plus(score)
      train = Train.where(id: params["id"]).first_or_initialize
      train.adequacy_flag = [train.adequacy_flag + score, 10].min
      train.save
  end

  def train_adequacy_minus(reply)
    train = Train.where(user_id: current_user.id, tweet_id: @tweet.id, reply_id: reply.id).first_or_initialize #.limit(1) #.last #params[:id]
    train.adequacy_flag = [train.adequacy_flag - 1, 0].max
    train.save
    return train
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
