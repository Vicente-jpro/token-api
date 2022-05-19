class PostsController < ApplicationController

  before_action :authenticate # except: [ :index ]
  before_action :set_post, only: %i[ show update destroy ]

  include ActionController::HttpAuthentication::Token::ControllerMethods

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        # Compare the tokens in a time-constant manner, to mitigate
        # timing attacks.
        #ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
        hmac_secret = 'my$ecretK3y'
        JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }

      end
    end

end
