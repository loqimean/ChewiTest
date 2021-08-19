class UsersSearch
  FILTER_SIZE = 1000

  attr_reader :query, :filter

  def initialize(args = {})
    @query = args[:query]
    @filter = args[:filter_cities]
  end

  def search
    chewy_index
      .query(query_condition).limit(FILTER_SIZE)
      .aggs(aggregation_condition)
      .filter(filter_condition)
  end

  private

    def chewy_index
      UsersIndex
    end

    def aggregation_condition
      {
        filters: {
          global: {},
          aggs: {
            cities: {
              terms: {
                field: "city_id",
                size: FILTER_SIZE
              }
            }
          }
        }
      }
    end

    def query_condition
      return {
        match_all: {}
      } if query.blank?

      {
        query_string: {
          fields: [:name, :email],
          query: query
        }
      }
    end

    def filter_condition
      return {} if filter.blank?

      {
        bool: {
          must: [
            { terms: {
              "city_id": filter
            } }
          ]
        }
      }
    end
end
