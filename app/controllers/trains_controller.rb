class TrainsController < ApplicationController
  def index
    #@tweet = Question.find(params[:question_id])
    #@answers  = Answer.where(question_id: params[:question_id]).limit(4)
    #@trains   = Train.all
    @trains = Train.all
  end

  def new
    @tweet = Sentence.where( 'id >= ?', rand(Sentence.count) + 1 ).first
    client = Docomoru::Client.new(api_key: '6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')
    @docomo_reply = client.create_dialogue(@tweet.sentence).body["utt"]
    sent = Sentence.where(sentence: @docomo_reply).first_or_initialize #DBに含まれていたらそれをとる。無ければnew()
    sent.save
    @train = Train.new(tweet_id: @tweet.id)
  end

  def create    
    if params[:train][:sentence_id] == ""
      @new_reply = Sentence.create(sentence: params[:text_area])
      Train.create(tweet_id: @tweet.id, reply_id: @new_reply.id, adequacy_flag: 1) #hogeのID
    else
      Train.create(create_params)
    end
    redirect_to controller: :trains, action: :index
  end

  private
  def create_params
    params.require(:train).permit(:reply_id).merge(adequacy_flag: 1)
  end

end
