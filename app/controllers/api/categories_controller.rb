class Api::CategoriesController < ApplicationController
  def index
    @initial = "no"
    if params[:category_id].in?(['','child','grandchild'])
      @categories = []
      if params[:category_id] == "child"
        @initial = "child"
      elsif params[:category_id] == "grandchild"
        @initial = "grandchild"
      else
        @initial = "parent"
      end
    else
      category = Category.find(params[:category_id])
      @categories = category.children
    end
  end
end
