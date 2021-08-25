class ElasticAggregationsSerializer
  attr_reader :aggs, :details_hash

  def initialize(aggs)
    @aggs = aggs
  end

  def to_hash
    result = {}
    aggs.each do |filter_name, filter_data|
      bucket_rows = buckets(filter_data['available'])

      filter_data = bucket_rows.map do |bucket_row|
        serialize_row(filter_name, bucket_row)
      end

      filter_data = as_hash_with_keys(filter_data)

      result[filter_name] = filter_data
    end
    result
  end

  private

    def buckets(agg_data)
      agg_data.dig('buckets')
    end

    def row_key(backet_row)
      backet_row.dig('key')
    end

    def row_size(backet_row)
      backet_row.dig('doc_count')
    end

    def serialize_row(agg_name, backet_row)
      result = {
        key: row_key(backet_row),
        size: row_size(backet_row)
      }
    end

    def as_hash_with_keys(array, key = :key)
      array.index_by { |i| i[key] }
    end
end
