class Product::ProductAttributesController < ApplicationController
  before_action :set_product_attribute, only: [:show, :edit, :update, :destroy]

  # GET /product_attributes
  # GET /product_attributes.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @product_attributes = Product::ProductAttribute.order(:id).paginate(:per_page=>20,:page=>page)
    @nb_pages = (Product::ProductAttribute.all.count.to_f / 20.to_f).ceil
  end

  # GET /product_attributes/1
  # GET /product_attributes/1.json
  def show
  end

  # GET /product_attributes/new
  def new
    @product_attribute = Product::ProductAttribute.new
  end

  # GET /product_attributes/1/edit
  def edit
  end

  # POST /product_attributes
  # POST /product_attributes.json
  def create
    @product_attribute = Product::ProductAttribute.new(product_attribute_params)

    respond_to do |format|
      if @product_attribute.save
        format.html { redirect_to @product_attribute, notice: 'Product attribute was successfully created.' }
        format.json { render :show, status: :created, location: @product_attribute }
      else
        format.html { render :new }
        format.json { render json: @product_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_attributes/1
  # PATCH/PUT /product_attributes/1.json
  def update
    respond_to do |format|
      if @product_attribute.update(product_attribute_params)
        format.html { redirect_to @product_attribute, notice: 'Product attribute was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_attribute }
      else
        format.html { render :edit }
        format.json { render json: @product_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_attributes/1
  # DELETE /product_attributes/1.json
  def destroy
    @product_attribute.destroy
    respond_to do |format|
      format.html { redirect_to product_product_attributes_url, notice: 'Product attribute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_attribute
      @product_attribute = Product::ProductAttribute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_attribute_params
      params.require(:product_product_attribute).permit(:name, :value, :picture, :updated_by_id, :product_product_attribute_category_id)
    end
end
