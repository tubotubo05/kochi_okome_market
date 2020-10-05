class ItemsController < ApplicationController
  def index
  end


  def show
  end


  def new
    @item = Item.new
    @brand = ""
  end


  def create
    addBrand()
    createCategoryId()
    @item = Item.new(name: params[:item][:name], price: params[:item][:price], description: params[:item][:description], prefecture_id: params[:item][:prefecture], category_id: @category_id, brand_id: @brand_id, condition_id: params[:item][:condition], shipping_id: params[:item][:shipping_pay], shipping_day_id: params[:item][:shipping_day], user_id: current_user.id)
    if params[:item][:images] != nil
      @url = params[:item][:images][:image].tempfile
      if !@item.save
        render new_item_path
      else
        @image = ItemImage.create(image_url: @url, item_id: @item[:id])
      end
    else
      render new_item_path
    end
  end


  private

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
      @category_id = params[:item][:category]
    elsif params[:item][:category_grandchild] == "grandchild"
      @category_id = params[:item][:category_child]
    else
      @category_id = params[:item][:category_grandchild]
    end
  end

end
