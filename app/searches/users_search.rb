class UsersSearch
  FILTER_SIZE = 1000

  def search
    chewy_index
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
end
