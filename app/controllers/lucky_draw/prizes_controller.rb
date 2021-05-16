class LuckyDraw::PrizesController < ApplicationController
  before_action :set_lucky_draw_prize, only: [:show, :edit, :update, :destroy]

  # GET /lucky_draw_prizes
  # GET /lucky_draw_prizes.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @lucky_draw_prizes = LuckyDraw::Prize.paginate(:per_page=>20,:page=>page)
    @nb_pages = (LuckyDraw::Prize.all.count.to_f / 20.to_f).ceil
  end

  # GET /lucky_draw_prizes/1
  # GET /lucky_draw_prizes/1.json
  def show
  end

  # GET /lucky_draw_prizes/new
  def new
    @lucky_draw_prize = LuckyDraw::Prize.new
  end

  # GET /lucky_draw_prizes/1/edit
  def edit
  end

  # POST /lucky_draw_prizes
  # POST /lucky_draw_prizes.json
  def create
    @lucky_draw_prize = LuckyDraw::Prize.new(lucky_draw_prize_params)

    respond_to do |format|
      if @lucky_draw_prize.save
        format.html { redirect_to @lucky_draw_prize, notice: 'Lucky draw prize was successfully created.' }
        format.json { render :show, status: :created, location: @lucky_draw_prize }
      else
        format.html { render :new }
        format.json { render json: @lucky_draw_prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lucky_draw_prizes/1
  # PATCH/PUT /lucky_draw_prizes/1.json
  def update
    respond_to do |format|
      if @lucky_draw_prize.update(lucky_draw_prize_params)
        format.html { redirect_to @lucky_draw_prize, notice: 'Lucky draw prize was successfully updated.' }
        format.json { render :show, status: :ok, location: @lucky_draw_prize }
      else
        format.html { render :edit }
        format.json { render json: @lucky_draw_prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lucky_draw_prizes/1
  # DELETE /lucky_draw_prizes/1.json
  def destroy
    @lucky_draw_prize.destroy
    respond_to do |format|
      format.html { redirect_to lucky_draw_prizes_url, notice: 'Lucky draw prize was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # SHOW code
  def show_code
    page = params[:page].nil? ? 1 : params[:page].to_i
    @lucky_draw_prize_codes = LuckyDraw::Prize::Code.where(lucky_draw_prize_id: params[:id]).order(created_at: :desc).paginate(:per_page=>20,:page=>page)
    @nb_pages = (LuckyDraw::Prize::Code.where(lucky_draw_prize_id: params[:id]).all.count.to_f / 20.to_f).ceil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lucky_draw_prize
      @lucky_draw_prize = LuckyDraw::Prize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lucky_draw_prize_params
      params.require(:lucky_draw_prize).permit(:name, :product_package_id, :prize_type, :quantity, :sample_prize, :status)
    end
end
