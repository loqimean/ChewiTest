class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @filters = filters_collection
    @users = collection

    respond_to do |format|
      format.html
      format.xlsx
      format.xml do
        @xml_file = UsersXmlTool.new(@users).generate_from_collection
        send_data @xml_file, filename: 'users.xml'
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    city = City.find_by(name: user_params[:city_attributes][:name])

    if city then @user.city = city end

    Chewy.strategy(:urgent) do
      respond_to do |format|
        if @user.save
          @filters = filters_collection

          format.turbo_stream
        else
          format.turbo_stream { render :create_has_errors }
        end
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    Chewy.strategy(:urgent) do
      respond_to do |format|
        if @user.update(user_params)
          @filters = filters_collection

          format.turbo_stream
        else
          format.turbo_stream { render :update_has_errors }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    Chewy.strategy(:urgent) do
      @user.destroy
    end

    @filters = filters_collection

    respond_to do |format|
      format.turbo_stream
    end
  end

  def search
    @users = collection

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :seniority,
                                   city_attributes: [:name])
    end

    def search_params
      params.permit(:query, :city_ids, :seniorities)
    end

    def parsed_filters_params(parameters)
      parameters.to_s.split(',')
    end

    def collection
      UsersSearch.new(
        query: search_params[:query],
        filter_cities: parsed_filters_params(search_params[:city_ids]),
        filter_seniorities: parsed_filters_params(search_params[:seniorities])
      ).search
    end

    def filters_collection
      ElasticAggregationsSerializer.new(collection.aggregations).to_hash
    end
end
