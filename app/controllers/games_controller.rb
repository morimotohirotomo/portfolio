class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @games = Game.all
  end

  def show
  	@game = Game.find_by(id: params[:id])
  end

  def new
  	@game = Game.new
  	@game.game_images.build
  end

  def create
  	@game = Game.new(game_params)
  	@game.user_id = current_user.id
  	if @game.save
  	  redirect_to game_path(@game)
  	else
  	  render :new
  	end
  end

  def edit
  	@game = Game.find_by(id: params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
  	  redirect_to game_path(@game)
    else
  	  render :edit
    end
  end

  def destroy
  	@games = Game.find(params[:id])
  	@game.destroy
  	redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:user_id, :category_id, :title, :content, :player, :playing_time, :level, game_rules_attributes: [:id, :image, :text, :_destroy])
  end
end