class UsersSearch
  FILTER_SIZE = 1000

  attr_reader :query, :filter

  def initialize(args = {})
    @query = args[:query]
    @filter = {cities: args[:filter_cities], seniorities: args[:filter_seniorities]}
  end

  def search
    chewy_index
      .query(query_condition)
      .limit(FILTER_SIZE)
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
                field: 'city_id',
                size: FILTER_SIZE
              }
            },
            seniorities: {
              terms: {
                field: 'seniority',
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
          fields: [:name, :email, :seniorities],
          query: query
        }
      }
    end

    def filter_condition
      return {} if filter[:cities].blank?

      bool_must_template(filter_terms.values)
    end

    def terms_template(key, value)
      return unless value.present?

      {
        terms: {
          key => value
        }
      }
    end

    def filter_terms
      {
        cities: terms_template("city_id", filter[:cities]),
        seniorities: terms_template('seniority', filter[:seniorities])
      }
    end

    def bool_must_template(filters)
      {
        bool: {
          must: filters.compact
        }
      }
    end
end
