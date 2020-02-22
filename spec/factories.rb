FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@text.user"
    end
    password { 'mypassword' }
  end

  factory :rook do
    game
    type        { 'Rook' }
    player_id   { 2 }
    x_position  { 0 }
    y_position  { 0 }
    captured    { false }
    color       { 'white' }
  end

  factory :knight do
    game
    type        { 'Knight' }
    player_id   { 1 }
    x_position  { 1 }
    y_position  { 0 }
    captured    { false }
    color       { 'white' }
  end

  factory :bishop do
    game
    type        { 'Bishop' }
    player_id   { 1 }
    x_position  { 2 }
    y_position  { 0 }
    captured    { false }
    color       { 'white' }
  end

  factory :king do
    game
    type        { 'King' }
    player_id   { 1 }
    x_position  { 4 }
    y_position  { 0 }
    captured    { false }
    color       { 'white' }
  end

  factory :queen do
    game
    type        { 'Queen' }
    player_id   { 1 }
    x_position  { 3 }
    y_position  { 0 }
    captured    { false }
    color       { 'white' }
  end

  factory :pawn do
    game
    type        { 'Pawn' }
    player_id   { 1 }
    x_position  { 0 }
    y_position  { 1 }
    captured    { false }
    color       { 'white' }
  end

  factory :game do
    name { 'New game' }
    black_player_id { 1 }
    white_player_id { 2 }

    trait :populated do
      user1 = user
      user2 = user
      after(:create) do |game|
        game.update_attributes(white_player_id: user1.id, black_player_id: user2.id)
        game.populate_white_pieces
        game.populate_black_pieces
      end
    end
  end
end
