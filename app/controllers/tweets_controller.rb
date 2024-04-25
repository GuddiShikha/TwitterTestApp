class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:edit, :update, :destroy]

  def index
    @tweets = current_user.tweets
  end

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def show
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @tweet }
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to tweets_path, alert: "Tweet not found" }
      format.json { render json: { error: "Tweet not found" }, status: :not_found }
    end
  end


  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: 'Tweet was successfully updated.'
    else
      render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.js
    end
  end
  private

  def set_tweet
    @tweet = current_user.tweets.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
