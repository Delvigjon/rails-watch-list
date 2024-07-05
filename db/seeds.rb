# db/seeds.rb

# Create or update movies
movie1 = Movie.find_or_create_by(title: "Wonder Woman 1984") do |movie|
  movie.overview = "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s"
  movie.poster_url = "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"
  movie.rating = 6.9
end

movie2 = Movie.find_or_create_by(title: "The Shawshank Redemption") do |movie|
  movie.overview = "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison"
  movie.poster_url = "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg"
  movie.rating = 8.7
end

movie3 = Movie.find_or_create_by(title: "Titanic") do |movie|
  movie.overview = "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic."
  movie.poster_url = "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"
  movie.rating = 7.9
end

movie4 = Movie.find_or_create_by(title: "Ocean's Eight") do |movie|
  movie.overview = "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century."
  movie.poster_url = "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg"
  movie.rating = 7.0
end

# Create or update lists
list1 = List.find_or_create_by!(name: "Drama") do |list|
  list.background_image_url = "https://images.pexels.com/photos/5941767/pexels-photo-5941767.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
end

list2 = List.find_or_create_by!(name: "Action") do |list|
  list.background_image_url = "https://images.pexels.com/photos/163347/war-desert-guns-gunshow-163347.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
end

list3 = List.find_or_create_by!(name: "Romance") do |list|
  list.background_image_url = "https://images.pexels.com/photos/704748/pexels-photo-704748.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
end

# Create or update bookmarks
Bookmark.find_or_create_by(comment: "Great movie!", movie: movie1, list: list2)
Bookmark.find_or_create_by(comment: "Must watch!", movie: movie2, list: list1)
Bookmark.find_or_create_by(comment: "Classic love story", movie: movie3, list: list3)
Bookmark.find_or_create_by(comment: "Heist movie with a twist", movie: movie4, list: list2)

puts "Seed data updated successfully!"
