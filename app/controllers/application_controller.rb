class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:botname])
  end

  def choose_reply(user_id, sentence)
    reply = user_reply(user_id, sentence)
    if reply.blank?
      reply = docomo_reply(sentence)
    end
    return reply
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

  def docomo_reply(sentence)
    client = Docomoru::Client.new(api_key: '6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')
    while true
      reply = client.create_dialogue(sentence).body["utt"]
      if reply.length < 30
        break
      end
    end
    Sentence.where(sentence: reply).first_or_create
  end



end
