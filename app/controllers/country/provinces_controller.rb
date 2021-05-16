class Country::ProvincesController < ApplicationController
  before_action :set_country_province, only: [:show, :edit, :update, :destroy]

  # GET /provinces
  # GET /provinces.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @country_provinces = Country::Province.paginate(:per_page=>20,:page=>page)
    @nb_pages = (Country::Province.all.count.to_f / 20.to_f).ceil
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
  end

  # GET /provinces/new
  def new
    @country_province = Country::Province.new
  end

  # GET /provinces/1/edit
  def edit
  end

  # POST /provinces
  # POST /provinces.json
  def create
    @country_province = Country::Province.new(country_province_params)

    respond_to do |format|
      if @country_province.save
        format.html { redirect_to @country_province, notice: 'Province was successfully created.' }
        format.json { render :show, status: :created, location: @country_province }
      else
        format.html { render :new }
        format.json { render json: @country_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provinces/1
  # PATCH/PUT /provinces/1.json
  def update
    respond_to do |format|
      if @country_province.update(country_province_params)
        format.html { redirect_to @country_province, notice: 'Province was successfully updated.' }
        format.json { render :show, status: :ok, location: @country_province }
      else
        format.html { render :edit }
        format.json { render json: @country_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provinces/1
  # DELETE /provinces/1.json
  def destroy
    @country_province.destroy
    respond_to do |format|
      format.html { redirect_to country_provincess_url, notice: 'Province was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country_province
      @country_province = Country::Province.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_province_params
      params.require(:country_province).permit(:name, :latitude, :longitude, :country_id)
    end
end
