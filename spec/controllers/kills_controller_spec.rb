require 'rails_helper'

RSpec.describe KillsController, type: :controller do

  describe '#index' do
    it 'should get the first and last kills' do
      kill = FactoryGirl.create(:kill)
      get :index
      expect(response.body).to eq ({ count: 1, first_id: kill.id, last_id: kill.id }.to_json)
    end     
  end

  describe '#show' do
    it 'should get kill attributes' do
      kill = FactoryGirl.create(:kill)
      get :show, id: kill.id
      expect(response.body).to eq ({ id: kill.id , killer_id: kill.killer_id ,
                                     victim_id: kill.victim_id, game_id: kill.game_id,
                                     method: nil , created_at: kill.created_at,
                                     updated_at: kill.updated_at }.to_json)
    end   
  end

  describe '#details' do
    it 'should get kill attributes' do
      kill = FactoryGirl.create(:kill)
      get :details, kill_id: kill.id
      expect(response.body).to eq ({ killer: kill.killer.name,
                                     victim: kill.victim.name,
                                     method: nil,
                                     game_id: kill.game_id }.to_json)
    end
  end 
end
