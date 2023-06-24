class WordsController < ApplicationController
  
  def show
    @word = Word.find(params[:id])
  end

  def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def edit
    @word = Word.find(params[:id])
  end

  def create
    @word = Word.new(params.require(:word).permit(:original, :translation))
    if @word.save
      flash[:notice] = "Word was created successfully."
      redirect_to @word
    else
      render 'new'
    end
  end
  
  def update
    @word = Word.find(params[:id])
    if @word.update(params.require(:word).permit(:original, :translation))
      flash[:notice] = "Word was updated successfully."
      redirect_to @word
    else
      render 'edit'
    end
  end
end
