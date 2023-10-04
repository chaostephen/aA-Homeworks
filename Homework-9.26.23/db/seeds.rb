# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationRecord.transaction do
  # These `destroy_all` commands are not necessary if you use `rails
  # db:seed:replant`
  puts 'Destroying tables...'
  ArtworkCollection.destroy_all
  Collection.destroy_all
  Like.destroy_all
  Comment.destroy_all
  ArtworkShare.destroy_all
  Artwork.destroy_all
  User.destroy_all

  # Reset the id (i.e., primary key) counters for each table to start at 1
  # (helpful for debugging)
  puts 'Resetting id sequences...'
  %w(users artworks artwork_shares comments likes collections artwork_collections).each do |table_name|
    ApplicationRecord.connection.reset_pk_sequence!(table_name)
  end

  # Create seed data
  puts 'Seeding the DB...'
  user1 = User.create!(username: 'robert')
  user2 = User.create!(username: 'sally')
  user3 = User.create!(username: 'bill')
  artwork1 = Artwork.create!(title: 'nighthawks', image_url: 'google.com', artist_id: user1.id)
  artwork2 = Artwork.create!(title: 'mona lisa', image_url: 'google1.com', artist: user2)
  ArtworkShare.create!(artwork: artwork1, viewer: user2)
  ArtworkShare.create!(artwork_id: artwork2.id, viewer_id: user3.id)
  comment1 = Comment.create!(body: 'great!', author: user1, artwork: artwork1)
  comment2 = Comment.create!(body: 'another great one', author: user2, artwork: artwork2)
  Like.create!(liker: user1, likeable_id: comment1.id, likeable_type: 'Comment')
  Like.create!(liker: user2, likeable_id: artwork2.id, likeable_type: 'Artwork')
  Like.create!(liker: user1, likeable_id: artwork2.id, likeable_type: 'Artwork')
  Like.create!(liker: user2, likeable_id: comment1.id, likeable_type: 'Comment')
  collection1 = Collection.create!(name: "My first Collection!", user: user1)
  collection2 = Collection.create!(name: "Birds, Birds, Birds", user: user2)
  ArtworkCollection.create!(collection: collection1, artwork: artwork1)
  ArtworkCollection.create!(collection: collection1, artwork: artwork2)
  ArtworkCollection.create!(collection: collection2, artwork: artwork2)

  puts 'Done!'
end