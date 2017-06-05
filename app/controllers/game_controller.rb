class GameController < ApplicationController
  def score
    @grid = params[:grid]
    @answer = params[:answer]
    @start_time = Time.now
    @end_time = Time.now
    @arbi = run_game(@answer, @grid, @start_time, @end_time)
  end

  def words
    @some = generate_grid(9)
  end

  require 'open-uri'
require 'json'

def generate_grid(grid_size)
  return (0...grid_size.to_i).map { (65 + rand(26)).chr }
  # TODO: generate random grid of letters
end

def check_attempt(attempt, grid)
  splitted_attempt = attempt.upcase.split("")
  if splitted_attempt.all? { |i| grid.include? i } && splitted_attempt.all? { |i| splitted_attempt.count(i) <= grid.count(i)}
    return attempt
  else
    return 0
end
end

def run_game(attempt, grid, start_time, end_time)
  url = "https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=c0924cff-8101-4a2b-bcaa-c6b22bb78b94&input=#{attempt}"
  user_serialized = open(url).read
  user = JSON.parse(user_serialized)

  elapsed_time = end_time.to_f - start_time.to_f
  score = (attempt.size * 10) - elapsed_time
  translation = user["outputs"][0]["output"].to_s

  if check_attempt(attempt, grid) == 0
    return bad_hash = {
      :time => elapsed_time,
      :translation => translation,
      :score => 0,
      :message => "not in the grid"
    }
  elsif attempt == translation
    return bad_hash1 = {
      :time => elapsed_time,
      :translation => nil,
      :score => 0,
      :message => "not an english word"
    }
  else
    return good_hash = {
      :time => elapsed_time,
      :translation => translation,
      :score => score,
      :message => "well done"
    }
  end

  end

end
