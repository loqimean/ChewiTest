class UsersXmlTool
  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def generate_from_collection
    Nokogiri::XML::Builder.new do |xml|
      xml.root do
        xml.users do
          collection.each do |user|
            xml.user do
              xml.id user.id
              xml.name user.name
              xml.email user.email
              xml.seniority user.seniority
            end
          end
        end
      end
    end.to_xml
  end
end
