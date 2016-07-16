require 'rails_helper'

RSpec.describe GameLog, type: :model do

	let(:game_log) { GameLog.new('21:07 Kill: 1022 2 22: Lion killed Isgalamido by MOD_TRIGGER_HURT') }

  describe '#genre' do
  	context 'When the game log is a game initialization' do
	  	let(:game_log) { GameLog.new('0:00 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner') }

	  	it 'should return InitGame' do
	  		expect(game_log.genre).to eq 'InitGame'
	  	end
  	end

		context 'When the game log is a game kill' do
	  	let(:game_log) { GameLog.new('21:07 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT') }

	  	it 'should return Kill' do
	  		expect(game_log.genre).to eq 'Kill'
	  	end
  	end  	
  end

  describe 'Fetching info from log' do
	  context '#get_killer_name' do
	  	it 'should return Lion' do
		  	expect(game_log.get_killer_name).to eq 'Lion'
		  end
	  end

	  describe '#get_victim_name' do
	  	it 'should return Isgalamido' do
		  	expect(game_log.get_victim_name).to eq 'Isgalamido'
		  end
	  end

	  describe '#get_method' do
	  	it 'should return Lion' do
		  	expect(game_log.get_method).to eq 'MOD_TRIGGER_HURT'
		  end
	  end
  end

  describe '#create_kill' do
  	it 'shoudl create a Kill' do
  		# Creat kill model
  		expect(Kill).to receive(:create)
  		game_log.create_kill
  	end
  end
end
