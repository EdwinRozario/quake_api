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

    it 'should get the first and last games' do
      game = FactoryGirl.create(:game)
      allow(Game).to receive(:first).and_return(game)
      allow(Game).to receive(:last).and_return(game)

      get :index
      expect(response.body).to eq ({ count: 1, first_id: game.id, last_id: game.id }.to_json)
    end         
  end

  describe '#show' do
    it 'should get game with id' do
      expect(Game).to receive(:find_by_id).with('1')
      get :show, id: 1 
    end

    it 'should return error when game id dosent exist' do
      get :show, id: 1000
      expect(response.body).to eq ({ message: 'Game with 1000 dosent exist' }.to_json)
    end

    it 'should return json for a game if exist' do
      game = FactoryGirl.create(:game)
      get :show, id: game.id
      expect(response.body).to eq ({ id: game.id, created_at: game.created_at, updated_at: game.updated_at }.to_json)
    end    
  end

  describe '#details' do
    let(:game) { FactoryGirl.create(:game) }

    it 'should get the game with id' do
      expect(Game).to receive(:find_by_id).with('1')
      get :details, game_id: 1 
    end

    it 'should call details_for' do
      expect(controller).to receive(:details_for).with(game)
      get :details, game_id: game.id
    end

    it 'should respond details of the kill' do
      game = FactoryGirl.create(:game)
      get :details, game_id: game.id
      expect(response.body).to eq ({id: game.id, total_kills: 0, players: [], kills: {}}.to_json)
    end         
  end

  describe '#kill_modes' do
    let(:game) { FactoryGirl.create(:game) }
    
    context 'when id passed' do
      it 'should get the game with id' do
        expect(Game).to receive(:find_by_id).with("#{game.id}")
        get :kill_modes, game_id: game.id
      end

      it 'should call kill_modes_for' do
        expect(controller).to receive(:kill_modes_for).with(game)
        get :kill_modes, game_id: game.id
      end

      it 'should call kill_modes_for' do
        game = FactoryGirl.create(:game)
        allow(Game).to receive(:all).and_return([game])
        get :kill_modes, game_id: 'nill'
        expect(response.body).to eq ({"game-#{game.id}": {}}.to_json)
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
