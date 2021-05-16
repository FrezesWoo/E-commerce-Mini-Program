class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]
  before_action :find_mp_links, only: [:new, :create, :edit, :update]

  # GET /campaigns
  # GET /campaigns.json
  def index
    @slides = Campaign.where(page_type: :slide).all
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @slide = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @slide = Campaign.new(slide_params)

    respond_to do |format|
      if @slide.save
        format.html { redirect_to show_slide_path(@slide), notice: 'Home slide was successfully created.' }
        format.json { render :show, status: :created, location: @slide }
      else
        format.html { render :new }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @slide.update(slide_params)
        format.html { redirect_to show_slide_path(@slide), notice: 'Home slide was successfully updated.' }
        format.json { render :show, status: :ok, location: @slide }
      else
        format.html { render :edit }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to slides_url, notice: 'Home slide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_slide
    @slide = Campaign.find(params[:id])
  end

  def find_mp_links
    @product_link = ::MpLink.where("name = '产品'").first
    @product_package_link = ::MpLink.where("name ILIKE '%产品组合%'").first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def slide_params
    params.require(:campaign).permit(:name, :publish, :page_type, blocks_attributes: [:id, :_destroy, :ordering, :link, :mp_link_id, :image, :product_id, :product_package_id, :campaign_id])
  end
end
