require 'rails_helper'

RSpec.describe GamesController, type: :controller do
	describe "grams#index action" do
		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
		it "should list only available games" do
			available = build(:game_available)
			unavailable = build(:game_unavailable)
		end
	end
end
