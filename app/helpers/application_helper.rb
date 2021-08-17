module ApplicationHelper
  def clean_keys(model_obj)
    array_of_values = model_obj.attributes.except('created_at',
                                                  'updated_at').keys
    array_of_values.delete_if { |element| element.include?('id') }
  end

  def get_statistic_count_by_aggs(object)
    @cities_aggs = UsersSearch.new.search.aggs

    @cities_aggs['cities']['buckets'].each do |hash|
      if hash['key'] == object.id
        return hash['doc_count']
      end
    end
  end
end
