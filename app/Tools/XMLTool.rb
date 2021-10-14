class XMLTool
  attr_reader :collection, :keys

  def initialize(args)
    @collection = args[:collection]
  end

  def generate_from_collection
    Nokogiri::XML::Builder.new do |xml|
      xml.root do
        xml.objects do
          collection.each do |user|
            xml.object do
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
