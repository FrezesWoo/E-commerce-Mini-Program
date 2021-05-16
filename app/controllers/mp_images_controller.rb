class MpImagesController < ApplicationController
  before_action :set_mp_image, only: [:show, :edit, :update, :destroy]

  # GET /mp_images
  # GET /mp_images.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @mp_images = MpImage.order(:id).paginate(:per_page=>20,:page=>page)
    @nb_pages = (MpImage.all.count.to_f / 20.to_f).ceil
  end

  # GET /mp_images/1
  # GET /mp_images/1.json
  def show
  end

  # GET /mp_images/new
  def new
    @mp_image = MpImage.new
  end

  # GET /mp_images/1/edit
  def edit
  end

  # POST /mp_images
  # POST /mp_images.json
  def create
    @mp_image = MpImage.new(mp_image_params)

    respond_to do |format|
      if @mp_image.save
        format.html { redirect_to @mp_image, notice: 'Gift card was successfully created.' }
        format.json { render :show, status: :created, location: @mp_image }
      else
        format.html { render :new }
        format.json { render json: @mp_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mp_images/1
  # PATCH/PUT /mp_images/1.json
  def update
    respond_to do |format|
      if @mp_image.update(mp_image_params)
        format.html { redirect_to @mp_image, notice: 'Mp image was successfully updated.' }
        format.json { render :show, status: :ok, location: @mp_image }
      else
        format.html { render :edit }
        format.json { render json: @mp_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mp_images/1
  # DELETE /mp_images/1.json
  def destroy
    @mp_image.destroy
    respond_to do |format|
      format.html { redirect_to mp_images_url, notice: 'Mp image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mp_image
      @mp_image = MpImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mp_image_params
      params.require(:mp_image).permit(:name ,:updated_by_id, :image)
    end
end
