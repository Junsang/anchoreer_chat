require 'spec_helper'

RSpec.describe Chat, :type => :model do

  it "모델 생성 성공 해야 함" do
    expect(Chat.new).not_to be_valid
  end

  it "모델 저장 성공 해야 함" do
    chat = FactoryBot.create(:chat)
    expect(chat).to be_valid
  end
  
end