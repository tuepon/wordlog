class WordsController < ApplicationController
  before_action :set_word, only: %i[show edit update destroy]

  def index
    @words = current_user.words.all
  end

  def show
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def create
    @word = current_user.words.new(word_params)
    if @word.save
      flash[:notice] = 'Word was created successfully.'
      redirect_to @word
    else
      render 'new'
    end
  end

  def update
    if @word.update(word_params)
      flash[:notice] = 'Word was updated successfully.'
      redirect_to @word
    else
      render 'edit'
    end
  end

  def destroy
    @word.destroy
    redirect_to words_path
  end

  def import
    if params[:file].nil?
      redirect_to words_url
    else
      Word.import(params[:file])
      redirect_to words_url
    end
  end

  private

  def set_word
    @word = Word.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:title, :translation, :user_id, :show_like_count)
  end
end
