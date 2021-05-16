class StatisticsController < ApplicationController
  def index
    @orders = Order.order_by_day(params[:from], params[:to])
    @customers = Customer.order_by_day(params[:from], params[:to])
    @orders_paid_no_paid = Order.by_paid_unpaid_status(params[:from], params[:to])
    @orders_by_status = Order.by_status(params[:from], params[:to])
  end
end
