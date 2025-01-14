class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    
    respond_to do |format|
      if @post.save
        @topic = @post.topic
        @topic.last_post = @post
        @topic.save
        
        posts_count = Post.where(:topic => @topic).count
        last_page = (posts_count / 5.to_f).ceil

        format.html { redirect_to topic_path(@topic, :foo => "lala", :page => last_page) }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to "/topics/#{@post.topic_id}", notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    topic = @post.topic 
    
    if topic.last_post
      if @post.id == topic.last_post.id
        @post.topic.last_post = nil
        @post.topic.save 
      end
    end
    
    @post.destroy
    
    last_post = topic.posts.last 
    if last_post
      topic.last_post = last_post 
      topic.save 
    end
    
    respond_to do |format|
      format.html { redirect_to "/topics/#{@post.topic_id}", notice: 'Post was successfully destroyed.' }
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
      params.require(:post).permit(:title, :text, :user_id, :post_id, :topic_id)
    end
end
