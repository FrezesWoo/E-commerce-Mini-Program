class Product::ProductAttributeCategoriesController < ApplicationController
  before_action :set_product_attribute_category, only: [:show, :edit, :update, :destroy]

  # GET /product_attribute_categories
  # GET /product_attribute_categories.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @product_attribute_categories = Product::ProductAttributeCategory.order(:id).paginate(:per_page=>20,:page=>page)
    @nb_pages = (Product::ProductAttributeCategory.all.count.to_f / 20.to_f).ceil
  end

  # GET /product_attribute_categories/1
  # GET /product_attribute_categories/1.json
  def show
  end

  # GET /product_attribute_categories/new
  def new
    @product_attribute_category = Product::ProductAttributeCategory.new
  end

  # GET /product_attribute_categories/1/edit
  def edit
  end

  # POST /product_attribute_categories
  # POST /product_attribute_categories.json
  def create
    @product_attribute_category = Product::ProductAttributeCategory.new(product_attribute_category_params)

    respond_to do |format|
      if @product_attribute_category.save
        format.html { redirect_to @product_attribute_category, notice: 'Product attribute cateogry was successfully created.' }
        format.json { render :show, status: :created, location: @product_attribute_category }
      else
        format.html { render :new }
        format.json { render json: @product_attribute_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_attribute_categories/1
  # PATCH/PUT /product_attribute_categories/1.json
  def update
    respond_to do |format|
      if @product_attribute_category.update(product_attribute_category_params)
        format.html { redirect_to @product_attribute_category, notice: 'Product attribute cateogry was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_attribute_category }
      else
        format.html { render :edit }
        format.json { render json: @product_attribute_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_attribute_categories/1
  # DELETE /product_attribute_categories/1.json
  def destroy
    @product_attribute_category.destroy
    respond_to do |format|
      format.html { redirect_to product_product_attribute_categories_url, notice: 'Product attribute cateogry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_attribute_category
      @product_attribute_category = Product::ProductAttributeCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_attribute_category_params
      params.require(:product_product_attribute_category).permit(:name, :picture, :updated_by_id)
    end
end
