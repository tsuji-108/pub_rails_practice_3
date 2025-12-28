# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User seeds
users = [
  { email_address: "user@example.org",  password: "secret", password_confirmation: "secret" },
  { email_address: "user2@example.org", password: "secret", password_confirmation: "secret" },
  { email_address: "user3@example.com", password: "secret", password_confirmation: "secret" }
]

users.each do |attrs|
  User.find_or_create_by!(email_address: attrs[:email_address]) do |user|
    user.password = attrs[:password]
    user.password_confirmation = attrs[:password_confirmation]
  end
end

puts "Seeded #{User.where(email_address: users.map { |u| u[:email_address] }).count} users."

# Board seeds
boards = [
  { title: "board title 1",  description: "board description 1" },
  { title: "board title 2",  description: "board description 2" }
]

boards.each do |attrs|
  Board.find_or_create_by!(title: attrs[:title]) do |board|
    board.title = attrs[:title]
    board.description = attrs[:description]
  end
end

puts "Seeded #{Board.where(title: boards.map { |b| b[:title] }).count} boards."

# Discussion seeds
discussions = [
  { user_id: User.first.id, board_id: Board.first.id, title: "Thread title 1", description: "Thread description 1" },
  { user_id: User.first.id, board_id: Board.first.id, title: "Thread title 2", description: "Thread description 2" },
  { user_id: User.first.id + 1, board_id: Board.first.id + 1, title: "Thread title 3", description: "Thread description 3" },
  { user_id: User.first.id + 1, board_id: Board.first.id + 1, title: "Thread title 4", description: "Thread description 4" }
]

discussions.each do |attrs|
  Discussion.find_or_create_by!(user_id: attrs[:user_id], board_id: attrs[:board_id], title: attrs[:title], description: attrs[:description]) do |discussion|
    discussion.user  = User.find(attrs[:user_id])
    discussion.board = Board.find(attrs[:board_id])
    discussion.title = attrs[:title]
    discussion.description = attrs[:description]
  end
end

# Comment seeds
comments = [
  { user_id: User.first.id, discussion_id: Discussion.first.id, content: "content 1" },
  { user_id: User.first.id, discussion_id: Discussion.first.id, content: "content 2" },
  { user_id: User.first.id + 1, discussion_id: Discussion.first.id + 1, content: "content 3" },
  { user_id: User.first.id + 1, discussion_id: Discussion.first.id + 1, content: "content 4" }
]

comments.each do |attrs|
  Comment.find_or_create_by(user_id: attrs[:user_id], discussion_id: attrs[:discussion_id], content: attrs[:content]) do |comment|
    comment.user = User.find(attrs[:user_id])
    comment.discussion = Discussion.find(attrs[:discussion_id])
    comment.content = attrs[:content]
  end
end

puts "Seeded #{Comment.where(
  user_id: comments.map { |c| c[:user_id] },
  discussion_id: comments.map { |c| c[:discussion_id] },
  content: comments.map { |c| c[:content] }
  ).count} comments."
