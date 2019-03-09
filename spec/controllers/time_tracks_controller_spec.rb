require "rails_helper"

RSpec.describe TimeTracksController do
  describe '#new' do
    it 'should be ok' do
      get :new

      expect(response).to render_template(:new)
    end
  end
end
