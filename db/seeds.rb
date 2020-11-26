require "faker"
require "open-uri"
require "date"

puts "Destroying existing games..."
Game.destroy_all
puts "Destroying existing users..."
User.destroy_all

puts "Creating users..."

batman = User.create(email: "b@t.man", username: "batman", password:'123456')
robin = User.create(email: "r@b.in", username: "robin", password:'123456')

puts "Creating Monopoly game..."

game = Game.new(
  name: 'Monopoly',
  description: "Establish a monopoly to strangle your opponents to death like it's Cuba!",
  number_of_players: 20,
  user: batman,
  saved: true
)
game.save

puts "Adding a board..."

board = Board.new(
  width: 750,
  height: 750,
  posX: 650,
  posY: 135,
  angle: 0,
  game: game
)
board.save
board.photo.attach(io: File.open('app/assets/images/monopoly/Monopoly-board.jpg'), filename:"board-#{board.id}-image")

puts "Adding a card deck..."

deck = CardDeck.new(
  name: 'deck',
  posX: 1025,
  posY: 135,
  blind?: false,
  height: 200,
  width: 120,
  angle: 0,
  game: game
)
deck.save

puts "Adding individual cards to the card deck..."

card_hash = { 
'Baltic Avenue' => 'app/assets/images/monopoly/Baltic.PNG',
'Reading Railroad' => 'app/assets/images/monopoly/Reading Railroad.PNG',
'Oriental Avenue' => 'app/assets/images/monopoly/oriental.PNG',
'Vermont Avenue' => 'app/assets/images/monopoly/Vermont.PNG',
'Connecticut Avenue' => 'app/assets/images/monopoly/Connecticut.jpg',
'St. Charles Place' => 'app/assets/images/monopoly/St. Charles.PNG',
'Electric Company' => 'app/assets/images/monopoly/electric co.png',
'States Avenue' => 'app/assets/images/monopoly/States.PNG',
'Virginia Avenue' => 'app/assets/images/monopoly/Virginia.png',
'Pennsylvania Railroad' => 'app/assets/images/monopoly/Pennsylvania R.R..PNG',
'St. James Place' => 'app/assets/images/monopoly/St. James.PNG',
'Tennessee Avenue' => 'app/assets/images/monopoly/tennessee.png',
'New York Avenue' => 'app/assets/images/monopoly/new york.png',
'Kentucky Avenue' => 'app/assets/images/monopoly/Kentucky.PNG',
'Indiana Avenue' => 'app/assets/images/monopoly/Indiana.PNG',
'Illinois Avenue' => 'app/assets/images/monopoly/Illinois.PNG',
'B. & O. Railroad' => 'app/assets/images/monopoly/B & 0 R.R..PNG',
'Atlantic Avenue' => 'app/assets/images/monopoly/Atlantic.png',
'Ventnor Avenue' => 'app/assets/images/monopoly/Ventnor.PNG',
'Water Works' => 'app/assets/images/monopoly/water works.png',
'Marvin Gardens' => 'app/assets/images/monopoly/Marvin Gardens.PNG',
'Pacific Avenue' => 'app/assets/images/monopoly/Pacific.PNG',
'North Carolina Avenue' => 'app/assets/images/monopoly/North Carolina.PNG',
'Pennsylvania Avenue' => 'app/assets/images/monopoly/Pennsylvania.PNG',
'Shortline' => 'app/assets/images/monopoly/Short Line.PNG'
}

card_position = (1..card_hash.length).to_a
pos = 0
card_hash.each do |key, value| 
  card = Card.new(
    card_deck: deck,
    name: key,
    visibility: 'visible',
    position: card_position.pop,
    posY: 135 + pos,
    angle: 0,
    width: 120,
    height: 200
  )
  card.photo.attach(io: File.open(value), filename:"card-#{card.name}-image")
  card.save
  pos += 5
end

chance = CardDeck.new(
  name: 'chance',
  posX: 300,
  posY: 135,
  blind?: true,
  height: 200,
  width: 120,
  angle: 0,
  game: game
)

puts "Adding pieces..."

piece_hash = { 
'boat' => 'app/assets/images/monopoly/piece_boat.png',
'car' => 'app/assets/images/monopoly/piece_car.png',
'dog' => 'app/assets/images/monopoly/piece_dog.png',
'hat' => 'app/assets/images/monopoly/piece_hat.png',
'iron' => 'app/assets/images/monopoly/piece_iron.png',
'wheelcart' => 'app/assets/images/monopoly/piece_wheelcart.png'
}

nam = 0
piece_hash.each do |key, value| 
    piece = Piece.new(
    name: key,
    angle: 0,
    width: 50,
    height: 50,
    posY: 135 + nam,
    posX: 110,
    game: game
    )
    piece.photo.attach(io: File.open(value), filename:"piece-#{piece.name}-image")
    piece.save
    nam += 70
end

puts "Adding tokens..."

user_one_hashes = [user_one_1_bill_hash = {}, user_one_5_bill_hash = {}, user_one_10_bill_hash = {}, user_one_20_bill_hash = {}, user_one_50_bill_hash = {}, user_one_100_bill_hash = {}, user_one_500_bill_hash = {}]

user_two_hashes = [user_two_1_bill_hash = {}, user_two_5_bill_hash = {}, user_two_10_bill_hash = {}, user_two_20_bill_hash = {}, user_two_50_bill_hash = {}, user_two_100_bill_hash = {}, user_two_500_bill_hash = {}]

bank_hashes = [bank_1_bill_hash = {}, bank_5_bill_hash = {}, bank_10_bill_hash = {}, bank_20_bill_hash = {}, bank_50_bill_hash = {}, bank_100_bill_hash = {}, bank_500_bill_hash = {}]

user_one = {500 => 2, 100 => 4, 50 => 1, 20 => 1, 10 => 2, 5 => 1, 1 => 5}
user_two = {500 => 2, 100 => 4, 50 => 1, 20 => 1, 10 => 2, 5 => 1, 1 => 5}
bank = {500 => 16, 100 => 12, 50 => 28, 20 => 48, 10 => 36, 5 => 38, 1 => 30}

puts "Creating user bill hashes..."

a = 1
user_one.each do |key, value|
  user_one_hash = user_one_hashes[-a]
  i = 1
    value.times do
    user_one_hash["user #{key} bill nr.#{i}"] = "app/assets/images/monopoly/token_#{key}_bill.jpg"
    i += 1
  end
a += 1
end

c = 1
user_two.each do |key, value|
  user_two_hash = user_two_hashes[-c]
  v = 1
    value.times do
    user_two_hash["user #{key} bill nr.#{v}"] = "app/assets/images/monopoly/token_#{key}_bill.jpg"
    v += 1
  end
c += 1
end

puts "Creating bank bill hashes..."

b = 1
bank.each do |key, value|
  bank_hash = bank_hashes[-b]
  t = 1
    value.times do
    bank_hash["bank #{key} bill nr.#{t}"] = "app/assets/images/monopoly/token_#{key}_bill.jpg"
    t += 1
  end
b += 1
end

puts "Creating user bill objects and placing in the gameroom..."

num = 0
user_one_hashes.each do |key|
    key.each do |k, v|
        token = Token.new(
        name: k,
        angle: 0,
        width: 50,
        height: 50,
        posY: 135 + num,
        posX: 170,
        game: game
        )
        token.photo.attach(io: File.open(v), filename:"token-#{token.name}-image")
        token.save
        num += 2
        puts "Created #{token.name}"
    end
    num += 20
end

nym = 0
user_two_hashes.each do |key|
    key.each do |k, v|
        token = Token.new(
        name: k,
        angle: 0,
        width: 50,
        height: 50,
        posY: 135 + nym,
        posX: 230,
        game: game
        )
        token.photo.attach(io: File.open(v), filename:"token-#{token.name}-image")
        token.save
        nym += 2
        puts "Created #{token.name}"
    end
    nym += 20
end

puts "Creating bank bill objects and placing in the gameroom..."

nam = 0
bank_hashes.each do |key|
    key.each do |k, v|
        token = Token.new(
        name: k,
        angle: 0,
        width: 50,
        height: 50,
        posY: 135 + nam,
        posX: 290,
        game: game
        )
        token.photo.attach(io: File.open(v), filename:"token-#{token.name}-image")
        token.save
        nam += 1
        puts "Created #{token.name}"
    end
    nam += 40
end

puts "Creating houses and placing..."

x = 1
32.times do
    token = Token.new(
        name: 'green house',
        angle: 0,
        width: 50,
        height: 50,
        posY: 135,
        posX: 360,
        game: game
        )
        token.photo.attach(io: File.open('app/assets/images/monopoly/token_greenhouse.png'), filename:"#{token.name}-#{x}-image")
        token.save
        puts "Created #{token.name} nr #{x}"
    x += 1
end

y = 1
12.times do
    token = Token.new(
        name: 'red house',
        angle: 0,
        width: 50,
        height: 50,
        posY: 200,
        posX: 360,
        game: game
        )
    token.photo.attach(io: File.open('app/assets/images/monopoly/token_redhouse.png'), filename:"#{token.name}-#{y}-image")
    token.save
    puts "Created #{token.name} nr #{y}"
    y += 1
end

puts "Creating dice..."

offsetdice = 0
2.times do
    dice = Dice.new(
        game: game,
        faces: 6,
        posY: 200 + offsetdice,
        posX: 400,
        number_of_dices: 2)
    dice.photo.attach(io: File.open('app/assets/images/monopoly/dice_blank.png'), filename:"#{dice.name}-#{y}-image")
    dice.save
    puts "Created #{dice.name}"
    offsetdice += 30
end

puts "Creating Chess game..."

game_chess = Game.new(
  name: 'Chess',
  description: "Good ol' chess for ya",
  number_of_players: 2,
  user: batman,
  saved: true
)
game_chess.save

puts "Adding a chess board..."

board_chess = Board.new(
  width: 750,
  height: 750,
  posX: 450,
  posY: 130,
  angle: 0,
  game: game_chess
)
board_chess.save
board_chess.photo.attach(io: File.open('app/assets/images/chess/chessboard.jpg'), filename:"board-#{board_chess.id}-image")

puts "Adding chess pieces..."

chess_piece_hash = { 
    'piece white 1' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 2' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 3' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 4' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 5' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 6' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 7' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 8' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 9' => 'app/assets/images/chess/Chess_rlt60.png',
    'piece white 10' => 'app/assets/images/chess/Chess_nlt60.png',
    'piece white 11' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 12' => 'app/assets/images/chess/Chess_qlt60.png',
    'piece white 13' => 'app/assets/images/chess/Chess_klt60.png',
    'piece white 14' => 'app/assets/images/chess/Chess_plt60.png',
    'piece white 15' => 'app/assets/images/chess/Chess_nlt60.png',
    'piece white 16' => 'app/assets/images/chess/Chess_rlt60.png',
    'piece black 1' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 2' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 3' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 4' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 5' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 6' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 7' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 8' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 9' => 'app/assets/images/chess/Chess_rdt60.png',
    'piece black 10' => 'app/assets/images/chess/Chess_ndt60.png',
    'piece black 11' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 12' => 'app/assets/images/chess/Chess_qdt60.png',
    'piece black 13' => 'app/assets/images/chess/Chess_kdt60.png',
    'piece black 14' => 'app/assets/images/chess/Chess_pdt60.png',
    'piece black 15' => 'app/assets/images/chess/Chess_ndt60.png',
    'piece black 16' => 'app/assets/images/chess/Chess_rdt60.png'
    }

chess_piece_hash.each do |key, value| 
    chess_piece = Piece.new(
    name: key,
    angle: 0,
    width: 50,
    height: 50,
    game: game_chess
    )
    chess_piece.photo.attach(io: File.open(value), filename:"chess_piece-#{chess_piece.name}-image")
    chess_piece.save
    puts "Created #{chess_piece.name}"
end

puts "Creating white pieces..."

HORIZONTAL = 85
horizontal_offset = 0
horizontal_offset_lower_row = 0
init = 0
16.times do 
  init += 1
  piece = Piece.where(name: "piece white #{init}")[0]
  if init < 9
    piece.posX = 505 + horizontal_offset
    piece.posY = 690
    horizontal_offset += HORIZONTAL
  else
    piece.posX = 505 + horizontal_offset_lower_row
    piece.posY = 777
    horizontal_offset_lower_row += HORIZONTAL
  end
  piece.save
end

puts "Creating black pieces..."

horizontal_offset_b = 0
horizontal_offset_b_lower_row = 0
initt = 0
16.times do 
  initt += 1
  piece = Piece.where(name: "piece black #{initt}")[0]
  if initt < 9
    piece.posX = 505 + horizontal_offset_b
    piece.posY = 271
    horizontal_offset_b += HORIZONTAL
  else
    piece.posX = 505 + horizontal_offset_b_lower_row
    piece.posY = 190
    horizontal_offset_b_lower_row += HORIZONTAL
  end
  piece.save
end

puts "Succesfully seeded!"