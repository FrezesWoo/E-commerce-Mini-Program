class MpLinksController < ApplicationController
  before_action :set_mp_link, only: [:show, :edit, :update, :destroy]

  # GET /mp_links
  # GET /mp_links.json
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @mp_links = MpLink.paginate(:per_page=>20,:page=>page)
    @nb_pages = (MpLink.all.count.to_f / 20.to_f).ceil
  end

  # GET /mp_links/1
  # GET /mp_links/1.json
  def show
  end

  # GET /mp_links/new
  def new
    @mp_link = MpLink.new
  end

  # GET /mp_links/1/edit
  def edit
  end

  # POST /mp_links
  # POST /mp_links.json
  def create
    @mp_link = MpLink.new(mp_link_params)

    respond_to do |format|
      if @mp_link.save
        format.html { redirect_to @mp_link, notice: 'Mp link was successfully created.' }
        format.json { render :show, status: :created, location: @mp_link }
      else
        format.html { render :new }
        format.json { render json: @mp_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mp_links/1
  # PATCH/PUT /mp_links/1.json
  def update
    respond_to do |format|
      if @mp_link.update(mp_link_params)
        format.html { redirect_to @mp_link, notice: 'Mp link was successfully updated.' }
        format.json { render :show, status: :ok, location: @mp_link }
      else
        format.html { render :edit }
        format.json { render json: @mp_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mp_links/1
  # DELETE /mp_links/1.json
  def destroy
    @mp_link.destroy
    respond_to do |format|
      format.html { redirect_to mp_links_url, notice: 'Mp link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mp_link
      @mp_link = MpLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mp_link_params
      params.require(:mp_link).permit(:name, :param, :path)
    end
end
