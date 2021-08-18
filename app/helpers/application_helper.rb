module ApplicationHelper
  def clean_keys(model_obj)
    array_of_values = model_obj.attributes.except('created_at',
                                                  'updated_at').keys
    array_of_values.delete_if { |element| element.include?('id') }
  end
end
