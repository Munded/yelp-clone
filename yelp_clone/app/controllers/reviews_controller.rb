class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    review = @restaurant.reviews.create(review_params)
    review.user = current_user
    review.save
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user == @review.user
      @review.destroy
      flash[:notice] = 'Review Deleted Successfully'
      redirect_to '/restaurants'
    else 
      flash[:notice] = "Cannot Delete Review"
      redirect_to '/restaurants'
    end
  end

end
