class UsersController < ApplicationController
  MAX_LINE_ITEMS_ON_PAGE = 3

  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.order(:name)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { 
          redirect_to users_url, 
          notice: "User #{@user.name} was successfully created." 
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { 
          redirect_to users_url, 
          notice: "User #{@user.name} was successfully updated." 
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to users_url, notice: @user.errors[:base].first }
        format.json { head :no_content }
      end
    end
  end

  def orders
    @user = User.find(session[:user_id])
    @orders_with_line_items_and_products = @user.orders.includes(line_items: :product)
  end

  def line_items
    @page = params[:page].to_i || 0
    @line_items = User.find(session[:user_id])
      .line_items
      .includes(:product)
      .offset(@page * MAX_LINE_ITEMS_ON_PAGE)
      .limit(MAX_LINE_ITEMS_ON_PAGE)
      
    @max_pages = User.find(session[:user_id]).line_items.size
  end

  rescue_from 'User::Error' do |exception|
    redirect_to users_urls, notice: exception.message
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email)
    end
end
