class DouyinCustomersController < ApplicationController
  before_action :set_douyin_customer, only: [:show, :edit, :update, :destroy]

  # GET /douyin_customers
  # GET /douyin_customers.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @douyin_customers = DouyinCustomer.paginate(:per_page=>20,:page=>page)
    @nb_pages = (DouyinCustomer.all.count.to_f / 20.to_f).ceil
    respond_to do |format|
      format.html
      format.csv {
        douyin_customers = DouyinCustomer.all
        send_data douyin_customers.order('douyin_customers.created_at DESC').to_csv, filename: "Douyin-Customers-#{DateTime.now.strftime("%Y-%m-%d-%H-%M-%S")}.csv"
      }
    end
  end

  # GET /douyin_customers/1
  # GET /douyin_customers/1.json
  def show
  end

  # GET /douyin_customers/new
  def new
    @douyin_customer = DouyinCustomer.new
  end

  # GET /douyin_customers/1/edit
  def edit
  end

  # POST /douyin_customers
  # POST /douyin_customers.json
  def create
    @douyin_customer = DouyinCustomer.new(douyin_customer_params)

    respond_to do |format|
      if @douyin_customer.save
        format.html { redirect_to @douyin_customer, notice: 'Douyin customer was successfully created.' }
        format.json { render :show, status: :created, location: @douyin_customer }
      else
        format.html { render :new }
        format.json { render json: @douyin_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /douyin_customers/1
  # PATCH/PUT /douyin_customers/1.json
  def update
    respond_to do |format|
      if @douyin_customer.update(douyin_customer_params)
        format.html { redirect_to @douyin_customer, notice: 'Douyin customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @douyin_customer }
      else
        format.html { render :edit }
        format.json { render json: @douyin_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /douyin_customers/1
  # DELETE /douyin_customers/1.json
  def destroy
    @douyin_customer.destroy
    respond_to do |format|
      format.html { redirect_to douyin_customers_url, notice: 'Douyin customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_douyin_customer
    @douyin_customer = DouyinCustomer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def douyin_customer_params
    params.require(:douyin_customer).permit(:open_id, :union_id, :gender, :name, :douyin_data, :email, :phone)
  end
end
