require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  films_array = []
  response_string = RestClient.get("http://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string)
  response_hash["results"].each do |array|
    array.each do |key, value|
      if key == "name"
        if value.upcase == character.upcase
          films_array = array["films"]
        end
      end
    end
  end
  return films_array
end

def print_movies(films_array)
  films_array.each do |film|
    movie_response = RestClient.get(film)
    films_hash = JSON.parse(movie_response)
    puts films_hash["title"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
