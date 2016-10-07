class SentencesController < ApplicationController
  def index
    @sentences = Sentence.all
  end

  def new
    @sentence = Sentence.where( 'id >= ?', rand(Sentence.count) + 1 ).first
  end

  def create
    @sentence = Sentence.where(sent_params).first_or_create
  end

  private
  def sent_params
    params.require(:sentence).permit(:sentence)
  end

end
