class ProductsController < ApplicationController
  include ProductsHelper

  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :load_categories, only: [:new, :create, :edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_product
  
  def index
    if params[:category_id]
      @products = Product.where(category_id: params[:category_id]).order(:title).includes(:ratings)
    else
      @products = Product.all.order(:title).includes(:ratings)
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all.order(:title)

        ActionCable.server.broadcast('products', { 
          html: render_to_string('store/index', layout: false) 
        })
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def load_categories
      @categories = Category.all.pluck(:name, :id)
    end

    def product_params
      params.require(:product).permit(
        :title, :description, :image_url, :price,
        :enabled, :discount_price, :permalink, :category_id, images: []
      )
    end

    def invalid_product
      logger.error "Attempt to access invalid product #{params[:id]}"

      redirect_to products_url, notice: 'Invalid Product'
    end
end
