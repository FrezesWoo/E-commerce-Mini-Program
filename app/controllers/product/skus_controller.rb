class Product::SkusController < ApplicationController
  include ApplicationHelper
  before_action :set_sku, only: [:show, :edit, :update, :destroy]
  before_action :clear_cache, only: [:create, :update, :destroy]

  # GET /skus
  # GET /skus.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @skus = Product::Sku.eager_load(:translations).order(:id)
    @skus = @skus.where("product_sku_translations.name LIKE '%#{params[:name]}%' OR sku LIKE '%#{params[:name]}%'") if params[:name] && !params[:name].empty?
    @skus = @skus.paginate(:per_page=>20,:page=>page)
    @nb_pages = (Product::Sku.all.count.to_f / 20.to_f).ceil
  end

  # GET /skus/1
  # GET /skus/1.json
  def show
  end

  # GET /skus/new
  def new
    @sku = Product::Sku.new
  end

  # GET /skus/1/edit
  def edit
  end

  # POST /skus
  # POST /skus.json
  def create
    @sku = Product::Sku.new(sku_params)

    respond_to do |format|
      if @sku.save
        format.html { redirect_to @sku, notice: 'Sku was successfully created.' }
        format.json { render :show, status: :created, location: @sku }
      else
        format.html { render :new }
        format.json { render json: @sku.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skus/1
  # PATCH/PUT /skus/1.json
  def update
    respond_to do |format|
      if @sku.update(sku_params)
        format.html { redirect_to @sku, notice: 'Sku was successfully updated.' }
        format.json { render :show, status: :ok, location: @sku }
      else
        format.html { render :edit }
        format.json { render json: @sku.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skus/1
  # DELETE /skus/1.json
  def destroy
    if !Order::Sku.where(product_sku_id: @sku.id).empty?
      respond_to do |format|
        format.json { render json: "You can't remove an sku that has been ordered alraedy", status: :unprocessable_entity }
      end
    end
    @sku.destroy
    respond_to do |format|
      format.html { redirect_to product_skus_url, notice: 'Sku was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sku
      @sku = Product::Sku.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sku_params
      params.require(:product_sku).permit(:name, :price, :ordering, :product_id, :sku, :shipping_price, :currency, :description, :composition, :updated_by_id, :image, :limited_product,
                                          product_product_attributes_skus_attributes: [:product_attribute_category_id, :product_product_attribute_id, :sorting, :_destroy, :id],
                                          attachments_attributes: [:file, :alt, :weight, :_destroy, :id, :display, :updated_by_id],
                                          product_sku_limits_attributes: [:limit_start_date, :limit_end_date, :_destroy, :id, :quantity])
    end
end
