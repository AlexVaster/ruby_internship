class BroniesController < ApplicationController
  before_action :set_brony, only: %i[show edit update destroy]

  # GET /bronies or /bronies.json
  def index
    @bronies = Brony.all
  end

  # GET /bronies/1 or /bronies/1.json
  def show; end

  def get_status; end

  def get_id
    params.permit(:category, :date)
    require 'open-uri'

    # @id=open("http://localhost:8160/tickets"+prarms[:category].to_s+"")
    @id = rand(100).to_i
    @id
  end

  # GET /bronies/new
  def new
    @num = if Brony.last.nil?
             1
           else
             Brony.last.select(:number_brony).to_i + 1
           end
    @id_bilet = get_id
    @brony = Brony.new(id_ticket: @id_bilet, number_brony: @num, time_broby: Time.now)
  end

  # GET /bronies/1/edit
  def edit; end

  def check_time
    # Brony.each{|e| if e.select(params[:time_broby])-Time.now>5 e.destroy end}
  end

  # POST /bronies or /bronies.json
  def create
    @num = if Brony.last.nil?
             1
           else
             Brony.last.select(:number_brony).to_i + 1
           end
    @id_bilet = get_id
    @brony = Brony.new(id_ticket: @id_bilet, number_brony: @num, time_broby: Time.now)

    respond_to do |format|
      if @brony.save
        format.html { redirect_to @brony, notice: 'Brony was successfully created.' }
        format.json { render :show, status: :created, location: @brony }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brony.errors, status: :unprocessable_entity }
      end
    end
    #@brony.save
    #render json: { brony_number: @brony.number_brony }

    # check_time
  end

  # PATCH/PUT /bronies/1 or /bronies/1.json
  def update
    respond_to do |format|
      if @brony.update(brony_params)
        format.html { redirect_to @brony, notice: 'Brony was successfully updated.' }
        format.json { render :show, status: :ok, location: @brony }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brony.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bronies/1 or /bronies/1.json
  def destroy
    @brony.destroy
    respond_to do |format|
      format.html { redirect_to bronies_url, notice: 'Brony was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brony
    @brony = Brony.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def brony_params
    params.require(:brony).permit(:id_ticket, :number_brony, :time_broby)
  end
end
