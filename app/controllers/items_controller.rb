class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC').limit(6)
    @ladies = Item.where(category_id: 1).or(Item.where(category_id: 14..210)).order('created_at DESC').limit(6)
    @mens = Item.where(category_id: 2).or(Item.where(category_id: 211..354)).order('created_at DESC').limit(6)
    @book = Item.where(category_id: 5).or(Item.where(category_id: 629..686)).order('created_at DESC').limit(6)
    @home_appliances = Item.where(category_id: 8).or(Item.where(category_id: 897..982)).order('created_at DESC').limit(6)
  end


  def show
    @comment =Comment.new
    @comments =@item.comments.order(created_at: :desc)
    @tax = @item.price * 1.1
  end

  def edit
    @images = @item.item_images
    if @item.brand
      @brand = @item.brand.name
    end
    if @item.category.ancestry == nil
      @ancestry = "nil"
    else
      @ancestry = @item.category.ancestry
    end
  end

  def update
    addBrand()
    createCategoryId()
    changeBrandId()
    if !@item.update(item_params)
      message = '入力必須項目に入力してください'
      if params[:item][:price].to_i < 1
        message = '金額は1以上を入力してください'
      elsif params[:item][:price].to_i >= 10000000
        message = '金額は99,999,999以下を入力してください'
      end
      if params[:item][:name].length > 40
        message = '商品名は40文字以内で入力してください'
      end
      redirect_to edit_item_path(params[:id]), flash: {error: message}
    else
      redirect_to item_path(params[:id])
    end
  end

  def destroy
    @item = Item.find(params[:id]).destroy
    respond_to do |format|
      format.html {redirect_to user_path(current_user.id)}
      format.json
    end
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
    if @item.category.ancestry == nil
      @ancestry = "nil"
    else
      @ancestry = @item.category.ancestry
    end
    if params[:item][:item_images_attributes] != nil
      if !@item.save
        flash.now[:alert] = '入力必須項目に入力してください'
        if @item[:price] < 1
          flash.now[:alert] = '金額は1以上を入力してください'
        elsif @item[:price] >= 10000000
          flash.now[:alert] = '金額は99,999,999以下を入力してください'
        end
        if @item[:name].length > 40
          flash.now[:alert] = '商品名は40文字以内で入力してください'
        end
        render new_item_path
      end
    else
      flash.now[:alert] = '画像を追加してください'
      @item.item_images.build
      render new_item_path
    end
  end

  def purchase_confirmation
    @item = Item.find(params[:id])
    @destination = Destination.where(user_id: current_user.id).first
    if current_user.cards != []
      @card = Card.get_card(current_user.cards[0].customer_token)
    end
  end

  def cardnew
    @card = Card.new
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:id])
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    card = Card.where(user_id: current_user.id).first
    Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_token,
      currency: 'jpy'
    )
    @item.update( buyer_id: current_user.id)
    redirect_to purchased_item_path
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
      item_images_attributes: [:image_url, :_destroy, :id]).merge(category_id: @category_id, brand_id: @brand_id, user_id: current_user.id)
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

  def changeBrandId
    if params[:item][:brand] != nil
      brand_id = Brand.all.where(name: params[:item][:brand])
      @brand_id = brand_id[0].id
    else
      @brand_id = nil
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

  def self.get_card(customer_token)  ## カード情報を取得する
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
  
    customer = Payjp::Customer.retrieve(customer_token)
    card_data = customer.cards.first
  end


end
