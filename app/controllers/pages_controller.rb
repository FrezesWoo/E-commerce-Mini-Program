class PagesController < ApplicationController
  include ApplicationHelper
  include PagesHelper

  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :find_mp_links, only: [:new, :create, :edit, :update]
  before_action :clear_cache, only: [:update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @pages = Page.paginate(:per_page=>20,:page=>page)
    @nb_pages = (Page.all.count.to_f / 20.to_f).ceil
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_blocks/1
  # DELETE /page_blocks/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    def find_mp_links
      @product_link = ::MpLink.where("name = '产品'").first
      @product_package_link = ::MpLink.where("name ILIKE '%产品组合%'").first
      @product_free_link = ::MpLink.where("name ILIKE '%付邮试用%'").first
      @campaign_link = ::MpLink.where("name ILIKE '%活动页面%'").first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :slug, :updated_by_id,
                                   blocks_attributes: [:template, :status, :name, :title, :description, :image, :link, :ordering, :id, :_destroy, :updated_by_id, :has_arrows, :has_dots, :height, :link_width, :link_height, :sticky,
                                                       slides_attributes: [:title, :description, :image, :link, :mp_link_id, :product_id, :product_sku_id, :product_package_id, :link_type, :campaign_id, :page_id, :mp_name, :alt, :ordering, :id, :_destroy, :updated_by_id],
                                                       products_attributes: [:product_type, :product_sku_id, :product_package_id, :ordering, :id, :_destroy, :updated_by_id],
                                                       tabbars_attributes: [:target, :id, :anchor_hover, :anchor_active, :ordering]
                                   ])
    end
end
