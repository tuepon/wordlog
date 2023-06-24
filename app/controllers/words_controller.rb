class WordsController < ApplicationController
  
  def show
    @word = Word.find(params[:id])
  end

  def index
    @words = Word.all
  end

  def new

  end

  def create
    render plain: params[:word]
  end

end
