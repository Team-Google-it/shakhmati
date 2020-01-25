FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@text.user"
    end
    password { 'mypassword' }
  end

  factory :game do
    name {'Game 1'}
    factory :game_available do
      white_player_id {1}
      black_player_id {2}
    end
    factory :game_unavailable do
      white_player_id {3}
      black_player_id {nil}
    end
  end
end
