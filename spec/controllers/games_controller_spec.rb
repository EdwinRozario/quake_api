require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe '#index' do
    it 'should get the cound of games' do
      FactoryGirl.create(:game)
      expect(Game).to receive(:count)
      get :index
    end

    it 'should get the first and last games' do
      allow(Game).to receive(:first).and_return(FactoryGirl.build(:game))
      allow(Game).to receive(:last).and_return(FactoryGirl.build(:game))

      expect(Game).to receive(:first)
      expect(Game).to receive(:last)
      get :index
    end    
  end

  describe '#show' do
    it 'should get game with id' do
      expect(Game).to receive(:find_by_id).with('1')
      get :show, id: 1 
    end
  end

  describe '#details' do
    let(:game) { FactoryGirl.build(:game) }

    it 'should get the game with id' do
      expect(Game).to receive(:find_by_id).with('1')
      get :details, game_id: 1 
    end

    it 'should call details_for' do
      allow(Game).to receive(:find_by_id).and_return(game)
      expect(controller).to receive(:details_for).with(game) 
      get :details, game_id: 1
    end    
  end

  describe '#kill_modes' do
    let(:game) { FactoryGirl.build(:game) }
    
    context 'when id passed' do
      it 'should get the game with id' do
        expect(Game).to receive(:find_by_id).with('1')
        get :kill_modes, game_id: 1 
      end

      it 'should call kill_modes_for' do
        allow(Game).to receive(:find_by_id).and_return(game)
        expect(controller).to receive(:kill_modes_for).with(game)
        get :kill_modes, game_id: 1
      end        
    end

    context 'when id not passed but nill' do
      it 'should get the all games' do
        allow(Game).to receive(:all).and_return([])
        expect(Game).to receive(:all)
        get :kill_modes, game_id: 'nill'
      end
    end
  end

  describe '#details_for' do
    let(:game) { FactoryGirl.build(:game) }
    it 'should get real players' do
      allow(game).to receive(:real_players).and_return([])
      expect(game).to receive(:real_players)
      controller.details_for(game)
    end    
  end

  describe '#kill_modes_for' do
    let(:game) { FactoryGirl.build(:game) }
    it 'should get kills from game' do
      allow(game).to receive(:kills).and_return([])
      expect(game).to receive(:kills)
      controller.kill_modes_for(game)
    end    
  end        
end
