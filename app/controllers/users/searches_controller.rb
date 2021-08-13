class Users::SearchesController < ApplicationController
  def index
    respond_to do |format|
      format.turbo_stream do
          @searched_users = if search_params[:query] then UsersIndex.query(query_string: { fields: [:name, :email], query: search_params[:query] }) end

        render turbo_stream: turbo_stream.replace(
          :userListing,
          partial: "users/listing"
        )
      end
    end
  end

  private

    def search_params
      params.permit(:query)
    end
end
