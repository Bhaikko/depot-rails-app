class RatingsController < ApplicationController
  def create
    @rating = Rating.find_or_initialize_by(product_id: params[:product_id], user_id: session[:user_id])
    @rating.rating = params[:rating]
  
    respond_to do |format|
      if @rating.save
        format.json { render json: :created }
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end
end
