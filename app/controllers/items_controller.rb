class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index
  end


  def show
  end


  def new
    @item = Item.new
    @item.item_images.build
    @brand_id = ""
  end


  def create
    addBrand()
    createCategoryId()
    @item = Item.new(item_params)
    if @item[:brand_id] != nil
      @brand_id = @item.brand[:name]
    end
    if params[:item][:item_images_attributes] != nil
      if !@item.save
        flash.now[:alert] = '入力必須項目に入力してください'
        if @item[:price] < 1
          flash.now[:alert] = '金額は1以上を入力してください'
        end
        render new_item_path
      end
    else
      flash.now[:alert] = '画像を追加してください'
      @item.item_images.build
      render new_item_path
    end
    #binding.pry
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    if params[:item][:price] == ""
      params[:item][:price] = 0
    end
    params.require(:item).permit(:name, :price, :description, :prefecture_id, :condition_id, :shipping_id, :shipping_day_id, 
      item_images_attributes: [:image_url]).merge(category_id: @category_id, brand_id: @brand_id, user_id: current_user.id)
  end

  def addBrand
    nilBrand()
    if params[:item][:brand] != nil
      @brand_id = Brand.all.where(name: params[:item][:brand])
      if @brand_id == []
        @brand = Brand.create(name: params[:item][:brand])
        @brand_id = Brand.order(updated_at: :desc).limit(1)[0][:id]
      else
        @brand_id = @brand_id[0][:id]
      end
    end
  end

  def nilBrand
    if params[:item][:brand] == ""
      params[:item][:brand] = nil
    end
  end

  def createCategoryId
    if params[:item][:category_child] == nil || params[:item][:category_child] == "child"
      @category_id = params[:item][:category_id]
    elsif params[:item][:category_grandchild] == "grandchild"
      @category_id = params[:item][:category_child]
    else
      @category_id = params[:item][:category_grandchild]
    end
  end

end
