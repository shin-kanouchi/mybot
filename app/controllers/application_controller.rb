#require 'net/http'
#require 'uri'
#require 'pry'
#require 'json'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def choose_reply(user_id, sentence, topic_id)
    reply = user_reply(user_id, sentence)
    if reply.blank?
      reply = docomo_reply(sentence, topic_id)
    end
    return reply
  end

  def choose_2reply(user_id, sentence, topic_id)
    reply_list = user_n_reply(user_id, sentence)
    return reply_list[0][0], reply_list[1][0]
  end

  def user_reply(user_id, sentence, min_diff_score=30)
    reply = nil
    Train.where(user_id: user_id, adequacy_flag: 1..10).each do |train|
      lev = Levenshtein.distance(sentence, train.tweet.sentence)
      diff_score = 100 * lev / (train.tweet.sentence.length + 1)
      if diff_score < min_diff_score
        reply = train.reply
        min_diff_score = diff_score
      end
    end
    return reply
  end

  def user_n_reply(user_id, sentence, n=2)
    reply = nil
    nbest = []
    for num in 1..n do
      nbest.push(["", 200-num])
    end

    Train.where(user_id: user_id, adequacy_flag: 1..10).each do |train|
      lev = Levenshtein.distance(sentence, train.tweet.sentence)
      diff_score = 100 * lev / (train.tweet.sentence.length + 1)
      nbest.each_with_index do |one_best, i|
        if diff_score < one_best[1]
          nbest.insert(i, [train.reply, diff_score])
          nbest.pop()
          break
        end
      end
    end
    return nbest
  end

  def docomo_reply(sentence, topic_id)
    client = Docomoru::Client.new(api_key: '6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')
    while true
      reply = client.create_dialogue(sentence)
      if reply.body != nil and reply.body["utt"] != nil and reply.body["utt"].length < 30
        break
      end
    end
    Sentence.where(sentence: reply.body["utt"], source_flag: 1, topic_id: topic_id).first_or_create
  end

  def user_local_reply(sentence, topic_id)
    url = URI.parse(URI.escape("https://chatbot-api.userlocal.jp/api/chat?key=efa8ed2632f3e4588aa8&message=#{sentence}"))
    res = Net::HTTP.start(url.host, url.port, use_ssl: true){|http|
        http.get(url.path + "?" + url.query);
    }
    obj = JSON.parse(res.body)
    Sentence.where(sentence: obj["result"], source_flag: 2, topic_id: topic_id).first_or_create
  end

end
