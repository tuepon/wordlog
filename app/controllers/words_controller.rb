class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_word, only: %i[show edit update destroy]

  def index
    @q = Word.ransack(params[:q])

    if params[:q].present?
      @pagy, @words = pagy(@q.result(distinct: true), items: 15)
    else
      @pagy, @words = pagy(current_user.words.all, items: 15)
    end
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
      flash[:notice] = 'Word was saved successfully!'
      redirect_to @word
    else
      render 'new'
    end
  end

  def update
    if @word.update(word_params)
      flash[:notice] = 'Word was updated successfully!'
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
    if params[:file].present? && File.extname(params[:file]).downcase == '.csv'
      Word.import(params[:file], current_user)
      flash[:notice] = 'Words were successfully imported.'
    else
      flash[:alert] = 'Please upload a CSV file.'
    end
    redirect_to words_url
  end

  private

  def set_word
    @word = current_user.words.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:title, :translation, :user_id, :description)
  end
end
