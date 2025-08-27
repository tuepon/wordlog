class WordsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_own_word!, only: [:edit, :update, :destroy]
  before_action :set_word, only: %i[show edit update destroy]

  def index
    @q = Word.ransack(params[:q])
    words_scope = if params[:q].present?
                    @q.result(distinct: true)
                  else
                    (current_user ? current_user.words : Word.all)
                  end
    @pagy, @words = pagy(words_scope, limit: 15)
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
      flash[:notice] = 'Word was saved successfully!' # rubocop:disable Rails/I18nLocaleTexts
      redirect_to @word
    else
      render 'new'
    end
  end

  def update
    if @word.update(word_params)
      flash[:notice] = 'Word was updated successfully!' # rubocop:disable Rails/I18nLocaleTexts
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
      flash[:notice] = 'Words were successfully imported.' # rubocop:disable Rails/I18nLocaleTexts
    else
      flash[:alert] = 'Please upload a CSV file.' # rubocop:disable Rails/I18nLocaleTexts
    end
    redirect_to words_url
  end

  def export
    @words = Word.all

    respond_to do |format|
      format.csv do
        csv_data = CSV.generate(headers: true) do |csv|
          csv << %w[id word definition created_at updated_at] # ヘッダーを設定
          @words.each do |word|
            csv << [word.id, word.title, word.translation, word.created_at, word.updated_at]
          end
        end
        send_data csv_data, filename: "words_#{Time.zone.now.strftime('%Y%m%d')}.csv"
      end
    end
  end

  private

  def set_word
    @word = Word.find(params[:id])
  end

  def authorize_own_word!
    @word = Word.find(params[:id])
    return if @word.user == current_user

    redirect_to words_path, alert: '自分の単語しか操作できません。'
  end

  def word_params
    params.require(:word).permit(:title, :translation, :user_id, :description)
  end
end
