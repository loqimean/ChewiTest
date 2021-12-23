require "rails_helper"

RSpec.describe PeopleController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/people").to route_to("people#index")
    end

    it "routes to #new" do
      expect(get: "/people/new").to route_to("people#new")
    end

    it "routes to #show" do
      expect(get: "/people/test").to route_to("people#show", id: "test")
    end

    it "routes to #edit" do
      expect(get: "/people/test/edit").to route_to("people#edit", id: "test")
    end


    it "routes to #create" do
      expect(post: "/people").to route_to("people#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/people/test").to route_to("people#update", id: "test")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/people/test").to route_to("people#update", id: "test")
    end

    it "routes to #destroy" do
      expect(delete: "/people/test").to route_to("people#destroy", id: "test")
    end
  end
end
