class UsersSearch
  FILTER_SIZE = 1000

  attr_reader :query

  def initialize(args = {})
    @query = args[:query]
  end

  def search
    chewy_index
      .query(query_condition)
      .aggs(aggregation_condition)
  end

  private

    def chewy_index
      UsersIndex
    end

    def aggregation_condition
      {
        cities: {
          terms: {
            field: "city_id",
            size: FILTER_SIZE
          }
        }
      }
    end

    def query_condition
      return {} if query.blank?

      {
        query_string: {
          fields: [:name, :email],
          query: query
        }
      }
    end
end
