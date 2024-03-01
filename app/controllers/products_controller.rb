# frozen_string_literal: true

# Product controller
class ProductsController < ApplicationController
  before_action :load_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_url(@product), notice: t(:created_product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    if @product.update(product_params)
      redirect_to product_url(@product), notice: t(:updated_product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    redirect_to products_url, notice: t(:destroyed_product)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def load_product
    @product = Product.find_by(id: params[:id])
    return if @product

    redirect_to products_url, notice: t(:not_found, model: t(:product).capitalize)
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name)
  end
end
