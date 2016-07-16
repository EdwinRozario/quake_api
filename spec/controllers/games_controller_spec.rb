require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe '#index' do
    it 'should get the cound of games' do
      expect(Game).should receive(:count)
      controller.index
    end

    it 'should get the first and last games' do
      expect(Game).should receive(:first)
      expect(Game).should receive(:last)
      controller.index
    end    
  end

  describe '#show' do
    it 'should get game with id' do
      expect(Game).should receive(:find_by_id).with(1)
      controller.show(1)
    end
  end

  describe '#details' do
    it 'should get the game with id' do
      expect(Game).should receive(:find_by_id).with(1)
      controller.detsial(1)
    end

    it 'should get the cound of kills' do
      expect(Game).should receive(:find_by_id).with(1)
      controller.details(1)
    end    
  end    
end
