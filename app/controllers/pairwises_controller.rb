class PairwisesController < ApplicationController

  def new  # eval/eval_id/
    @eval = Evaluate.find(params["evaluate_id"])
    @tweet = Sentence.where( 'id >= ?', rand(Sentence.count) + 1 ).first #最近学習していないもので，という条件を付ける
    reply_x = choose_reply(@eval.user_x_id)
    reply_y = choose_reply(@eval.user_y_id)
    @pairwise = Pairwise.create(evaluate_id: @eval.id, tweet_id: @tweet.id, reply_x_id: reply_x.id, reply_y_id: reply_y.id)
  end

  def update #evaluates/:evaluate_id/:pairwise_id/:inequality_flag
    pairwise = Pairwise.find(params["pairwise_id"])
    pairwise.inequality_flag = params["inequality_flag"]
    pairwise.save
    if Evaluate.find(params["evaluate_id"]).pairwises.count >= 10
      redirect_to controller: :evaluates, action: :finish
    else
      redirect_to controller: :pairwises, action: :new
    end
  end

  private
  def choose_reply(user_id)
    min_diff_score = 30
    reply = nil
    Train.where(user_id: user_id, adequacy_flag: 1..10).each do |train|
      lev = Levenshtein.distance(@tweet.sentence, train.tweet.sentence)
      diff_score = 100 * lev / (train.tweet.sentence.length + 1)
      if diff_score < min_diff_score
        reply = train.reply
        min_diff_score = diff_score
      end
    end
    if reply.blank?
      reply = docomo_reply
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
