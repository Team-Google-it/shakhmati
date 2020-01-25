FactoryBot.define do
  factory :user do
    first_name {'John'}
    last_name {'Doe'}
    birthdate { 21.years.ago }
    admin { false }

    sequence(:username) { |n| "user#{n}" }
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
