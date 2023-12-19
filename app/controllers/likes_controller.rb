class LikesController < ApplicationController
  before_action :set_word

  def toggle_like
    if (@like = @word.likes.find_by(user: current_user))
      @like.destroy
    else
      @word.likes.create(user: current_user)
    end
  end

  private

  def set_word
    @word = Word.find(params[:word_id])
  end
end
