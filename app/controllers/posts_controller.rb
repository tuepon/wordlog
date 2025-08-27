class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
    posts_scope = if params[:tag].present?
                    Post.joins(:tags).where(tags: { name: params[:tag] }).distinct
                  else
                    Post.all
                  end

    @pagy, @posts = pagy(posts_scope, limit: 5)

    @tags = Tag.order(:name)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        update_tags(@post)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        update_tags(@post)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to post_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(
      :caption, :body, :user_id, :allow_comments, :show_likes_count, images: [], remove_image_ids: [], tags_attributes: [:name]
    )
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, alert: 'Not authorized to edit this post' if @post.nil?
  end

  def update_tags(post)
    Tag.where.missing(:taggings).destroy_all
    tag_names = params[:tag_names].to_s.split(',').map(&:strip).reject(&:empty?)
    post.tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }

    # Delete isolated tag.
    Tag.where.missing(:taggings).destroy_all
  end
end
