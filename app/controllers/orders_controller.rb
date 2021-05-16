class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :sync]

  # GET /orders
  # GET /orders.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @orders = Order.where(source: params[:source]).order('is_synced asc, created_at desc')
    @orders = @orders.where(order_number: params[:order_number]) if params[:order_number] && !params[:order_number].empty?
    @orders = @orders.where(status: params[:status]) if params[:status] && !params[:status].empty?
    @orders = @orders.paginate(:per_page=>20,:page=>page)
    @nb_pages = (Order.all.count.to_f / 20.to_f).ceil
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # SYNC /orders/1
  # SYNC /orders/1.json
  def sync
    oms = OmsD::OmsQuery.new()
    sync = oms.create_order(params[:id])
    @order.update({is_synced: true}) if sync["code"] == 200
    redirect_url = @order.source == "wechat" ? "/orders/source/0" : "/orders/source/1"
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: 'Order status was synchronously updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :order_number, :status, :address_id, :amount)
    end
end
