class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :clear_cache, only: [:create, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @products = Product.eager_load(:translations).order(:id)
    @products = @products.where("product_translations.name LIKE '%#{params[:name]}%'") if params[:name] && !params[:name].empty?
    @products = @products.paginate(:per_page=>20,:page=>page)
    @nb_pages = (Product.all.count.to_f / 20.to_f).ceil
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # GET /products/import_product
  def import_product
  end

  def import
    query = ::ProductCsv::CsvImport.new()
    query.upload_product(params[:file])
    redirect_to '/import_product', notice: "Successfully Imported Wechat Products."
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:description, :star_product, :ordering, :name, :note, :updated_by_id, :composition, :image, :product_category_id, attachments_attributes: [:file, :alt, :ordering, :_destroy, :id, :display, :updated_by_id], blocks_attributes: [:id, :_destroy, :template, :ordering, :image, :video, :link, :y_position, :x_position, :link_width, :link_height])
    end
end
