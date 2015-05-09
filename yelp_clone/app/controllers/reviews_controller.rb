class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    review = @restaurant.reviews.build_with_user(review_params, current_user)
    review.user = current_user
    review.save
    if review.save
      redirect_to restaurants_path
    else
      flash[:notice] = 'already reviewed this restaurant'
      redirect_to restaurants_path
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user == @review.user
      @review.destroy
      flash[:notice] = 'Review Deleted Successfully'
    else 
      flash[:notice] = "Cannot Delete Review"
    end
    redirect_to '/restaurants'
  end

end
