class LuckyDrawsController < ApplicationController
  before_action :set_order, only: [:show, :ship]

  # GET /lucky_draws
  # GET /lucky_draws.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @lucky_draws = LuckyDraw.where.not(lucky_draw_prize_id: nil).order(created_at: :desc)
    @lucky_draws = @lucky_draws.paginate(:per_page=>20,:page=>page) unless request.format == 'csv'
    @nb_pages = (LuckyDraw.all.count.to_f / 20.to_f).ceil
    respond_to do |format|
      format.html
      format.csv {
        send_data @lucky_draws.to_csv, filename: "Lucky_Draws-#{DateTime.now.strftime("%Y-%m-%d-%H-%M-%S")}.csv"
      }
    end
  end

  # GET /lucky_draws/1
  # GET /lucky_draws/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lucky_draw
      @lucky_draw = LuckyDraw.find(params[:id])
    end
end
