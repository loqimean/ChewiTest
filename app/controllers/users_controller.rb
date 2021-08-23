class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @filters = ElasticAggregationsSerializer.new(collection.aggregations).to_hash
    @users = collection
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @users = collection

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          :userListing,
          partial: 'users/listing',
          locals: { users: @users }
        )
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email)
    end

    def search_params
      params.permit(:query, :city_ids, :seniorities)
    end

    def parsed_filters_params(params)
      params.to_s.split(',')
    end

    def collection
      UsersSearch.new(
        query: search_params[:query],
        filter_cities: parsed_filters_params(search_params[:city_ids]),
        filter_seniorities: parsed_filters_params(search_params[:seniorities])
      ).search
    end
end
