FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@text.user"
    end
    password { 'mypassword' }
  end

  factory :game do
    name { 'New game' }
    black_player_id { 1 }
    white_player_id { 2 }
  end
end
