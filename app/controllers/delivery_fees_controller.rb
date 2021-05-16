class DeliveryFeesController < ApplicationController
  before_action :set_delivery_fee, only: [:show, :edit, :update, :destroy]

  # GET /delivery_fees
  # GET /delivery_fees.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @delivery_fees = DeliveryFee.paginate(:per_page=>20,:page=>page)
    @nb_pages = (DeliveryFee.all.count.to_f / 20.to_f).ceil
  end

  # GET /delivery_fees/1
  # GET /delivery_fees/1.json
  def show
  end

  # GET /delivery_fees/new
  def new
    @delivery_fee = DeliveryFee.new
  end

  # GET /delivery_fees/1/edit
  def edit
  end

  # POST /delivery_fees
  # POST /delivery_fees.json
  def create
    @delivery_fee = DeliveryFee.new(delivery_fee_params)

    respond_to do |format|
      if @delivery_fee.save
        format.html { redirect_to @delivery_fee, notice: 'Delivery fee was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_fee }
      else
        format.html { render :new }
        format.json { render json: @delivery_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_fees/1
  # PATCH/PUT /delivery_fees/1.json
  def update
    respond_to do |format|
      if @delivery_fee.update(delivery_fee_params)
        format.html { redirect_to @delivery_fee, notice: 'Delivery fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_fee }
      else
        format.html { render :edit }
        format.json { render json: @delivery_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_fees/1
  # DELETE /delivery_fees/1.json
  def destroy
    @delivery_fee.destroy
    respond_to do |format|
      format.html { redirect_to delivery_fees_url, notice: 'Delivery fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_fee
      @delivery_fee = DeliveryFee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_fee_params
      params.require(:delivery_fee).permit(:price, country_provinces_delivery_fees_attributes: [:id, :country_province_id, :_destroy])
    end
end
