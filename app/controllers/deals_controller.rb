class DealsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  def index
    @deals = Deal.all.order('created_at desc')
    @deal = @deals.last
  end

  def show
  end

  def new
    @deal = Deal.new
    @deal.uploads.build unless @deal.uploads.present?
    authorize @deal
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.user = current_user

    if @deal.save
      redirect_to @deal, notice: "Deal has been created successfully."
    else
      redirect_back fallback_location: @deal, alert: "Deal could not be created. #{@deal.errors.full_messages }}"
    end

    authorize @deal
  end

  def edit
  end

  def update
    @deal.update(deal_params)

    if @deal.save
      redirect_to @deal, notice: "Deal has been updated successfully."
    else
      redirect_back fallback_location: @deal, alert: "Deal could not be updated. #{@deal.errors.full_messages}"
    end
  end

  def destroy
    if @deal.destroy
      redirect_to deals_path, notice: "Deal has been deleted successfully."
    else
      redirect_back fallback_location: @deal, alert: "Deal could not be updated."
    end
  end

  private

    def set_deal
      @deal = Deal.find(params[:id])
      authorize @deal
    end

    def deal_params
      params.require(:deal).permit(:title, :brand_code, :price, :savings, :discount_code, :link, uploads_attributes: [:id, :upload, :featured] )
    end
end
