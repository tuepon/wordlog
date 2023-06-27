class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:notice] = "Word was created successfully."
      redirect_to @word
    else
      render 'new'
    end
  end
  
  def update
    if @word.update(word_params)
      flash[:notice] = "Word was updated successfully."
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
    Word.import(params[:file])
    redirect_to words_url
  end

  private

  def set_word
    @word = Word.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:original, :translation)
  end

end
