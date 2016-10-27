class TopicsController < ApplicationController

  def index
  end

  def show
    @topic = Topic.find(params[:id])
    @choice_exp = Train.where("user_id = ? and topic_id = ? and choice_count >= 1", current_user.id, params[:id]).count
    @free_exp = Train.where("user_id = ? and topic_id = ? and (free_b2u_count >= 1 or free_u2b_count >= 1)", current_user.id, params[:id]).count * 2
  end

end
