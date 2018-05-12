class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.order('created_at desc')
  end

  def show
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to @product, notice: "Product has been created successfully."
    else
      redirect_back fallback_location: @product, alert: "Product could not be created. #{@product.errors.full_messages }}"
    end

    authorize @product
  end

  def edit
  end

  def update
    @product.update(product_params)

    if @product.save
      redirect_to @product, notice: "Product has been updated successfully."
    else
      redirect_back fallback_location: @product, alert: "Product could not be updated. #{@product.errors.full_messages}"
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Product has been deleted successfully."
    else
      redirect_back fallback_location: @product, alert: "Product could not be updated."
    end
  end

  private

    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image)
    end
end
