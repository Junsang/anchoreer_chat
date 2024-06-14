FactoryBot.define do

  factory :chat do
    sequence(:id) {|n| n }
    title { "테스트 채팅1" }
  end

end