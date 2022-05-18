require "rails_helper"

RSpec.describe MediaFlowsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/media_flows").to route_to("media_flows#index")
    end

    it "routes to #new" do
      expect(get: "/media_flows/new").to route_to("media_flows#new")
    end

    it "routes to #show" do
      expect(get: "/media_flows/1").to route_to("media_flows#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/media_flows/1/edit").to route_to("media_flows#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/media_flows").to route_to("media_flows#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/media_flows/1").to route_to("media_flows#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/media_flows/1").to route_to("media_flows#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/media_flows/1").to route_to("media_flows#destroy", id: "1")
    end
  end
end
