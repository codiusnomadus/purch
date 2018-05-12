class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = Review.all.order('created_at desc')
  end

  def show
  end

  def new
    @review = Review.new
    @review.uploads.build unless @review.uploads.present?
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @review, notice: "Review has been created successfully."
    else
      redirect_back fallback_location: @review, alert: "Review could not be created. #{@review.errors.full_messages }}"
    end

    authorize @review
  end

  def edit
  end

  def update
    @review.update(review_params)

    if @review.save
      redirect_to @review, notice: "Review has been updated successfully."
    else
      redirect_back fallback_location: @review, alert: "Review could not be updated. #{@review.errors.full_messages}"
    end
  end

  def destroy
    if @review.destroy
      redirect_to reviews_path, notice: "Review has been deleted successfully."
    else
      redirect_back fallback_location: @review, alert: "Review could not be updated."
    end
  end

  private

    def set_review
      @review = Review.find(params[:id])
      authorize @review
    end

    def review_params
      params.require(:review).permit(:title, :body, :verdict, uploads_attributes: [:id, :upload, :featured] )
    end
end
