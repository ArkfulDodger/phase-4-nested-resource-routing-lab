class ItemsController < ApplicationController
  before_action :find_items
  before_action :find_item, only: %i[show]

  # GET /items || GET /users/:user_id/items
  def index
    render json: @items, include: :user
  end

  # GET /users/:user_id/items/:id
  def show
    render json: @item
  end

  # POST /users/:user_id/items
  def create
    new_item = @items.create!(item_params)
    render json: new_item, status: :created
  end

  private

  # set instance variable for show/update/destroy
  def find_item
    @item = @items.find(params[:id])
  end

  def find_items
    if (params[:user_id])
      @items = User.find(params[:user_id]).items
    else
      @items = Item.all
    end
  end

  # permissible params to be used by create/update
  def item_params
    params.permit(:name, :description, :price)
  end
end
