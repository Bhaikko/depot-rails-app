class RatingsController < ApplicationController
  def create
    @rating = Rating.find_or_initialize_by(product_id: params[:product_id], user_id: session[:user_id])
    @rating.rating = params[:rating]
    @rating.save

    respond_to do |format|
      format.js { render json: { status: 201 } }
    end
  end
end
