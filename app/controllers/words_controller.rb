class WordsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # index, showはログイン不要
  before_action :check_admin, only: [:create, :new] # 管理者のみ作成可能
  before_action :set_word, only: %i[show edit update destroy]

  def index
    @q = Word.ransack(params[:q])

    if params[:q].present?
      @pagy, @words = pagy(@q.result(distinct: true), items: 15)
    else
      @pagy, @words = pagy((current_user&.words || Word.none), items: 15)
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
            csv << [word.id, word.word, word.definition, word.created_at, word.updated_at]
          end
        end
        send_data csv_data, filename: "words_#{Time.zone.now.strftime('%Y%m%d')}.csv"
      end
    end
  end

  private

  def set_word
    @word = current_user.words.find(params[:id])
  end

  def check_admin
    return if current_user&.admin?
      redirect_to root_path, alert: '権限がありません' # rubocop:disable Rails/I18nLocaleTexts
  end

  def word_params
    params.require(:word).permit(:title, :translation, :user_id, :description)
  end

end
