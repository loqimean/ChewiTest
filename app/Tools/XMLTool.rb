class XMLTool
  attr_reader :collection, :keys

  def initialize(args)
    @collection = args.collection
    @keys = args.keys
  end

  def generate_from_collection(collection)
    Nokogiri::XML::Builder.new do |xml|
      xml.root do
        xml.objects do
          collection.each do |element|
            xml.object do

            end
          end
        end
      end
    end
  end
end