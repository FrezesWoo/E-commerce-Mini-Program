class Product::PackagesController < ApplicationController
  include ApplicationHelper
  before_action :set_product_package, only: [:show, :edit, :update, :destroy]
  before_action :clear_cache, only: [:create, :update, :destroy]

  # GET /product/packages
  # GET /product/packages.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @product_packages = Product::Package.eager_load(:translations).order(:id)
    @product_packages = @product_packages.where("product_package_translations.name LIKE '%#{params[:name]}%'") if params[:name] && !params[:name].empty?
    @product_packages = @product_packages.paginate(:per_page=>20,:page=>page)
    @nb_pages = (Product::Package.all.count.to_f / 20.to_f).ceil
  end

  # GET /product/packages/1
  # GET /product/packages/1.json
  def show
  end

  # GET /product/packages/new
  def new
    @product_package = Product::Package.new
    get_skus
  end

  # GET /product/packages/1/edit
  def edit
    get_skus
  end

  # POST /product/packages
  # POST /product/packages.json
  def create
    @product_package = Product::Package.new(product_package_params)
    get_skus
    respond_to do |format|
      if @product_package.save
        format.html { redirect_to @product_package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @product_package }
      else
        format.html { render :new }
        format.json { render json: @product_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/packages/1
  # PATCH/PUT /product/packages/1.json
  def update
    # byebug
    get_skus
    respond_to do |format|
      if @product_package.update(product_package_params)
        format.html { redirect_to @product_package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_package }
      else
        format.html { render :edit }
        format.json { render json: @product_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/packages/1
  # DELETE /product/packages/1.json
  def destroy
    @product_package.destroy
    respond_to do |format|
      format.html { redirect_to product_packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_package
      @product_package = Product::Package.find(params[:id])
    end

    def get_skus
      @product_skus = Hash.new()
      @product_package.product_package_products.each_with_index do |pr, idx|
        @product_skus[pr.product.id.to_s] =  pr.product.product_skus.map { |sku| { id: sku.id, name: sku.composed_name }}
      end
      @product_skus
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_package_params
      params.require(:product_package).permit(:name, :description, :note, :shipping_price, :star_product, :publish, :hidden_product, :ordering, :composition, :image, :page_id, :product_category_id,
                                              attachments_attributes: [:file, :ordering, :_destroy, :id, :display, :updated_by_id],
                                              product_package_products_attributes: [:id, :product_id, :_destroy, skus_attributes: [:id, :product_sku_id, :_destroy]],
                                              blocks_attributes: [:id, :_destroy, :template, :ordering, :image, :video, :link, :y_position, :x_position, :link_width, :link_height],
                                              trails_attributes: [:id, :_destroy, :trial_start_date, :trial_end_date])
    end
end
