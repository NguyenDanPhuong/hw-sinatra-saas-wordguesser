class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_reader :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(str)
    raise ArgumentError if str.nil? || str.empty? || str.match(/[^a-zA-Z]/)
    str.downcase!
    if @word.include?(str) && !@guesses.include?(str)
      @guesses << str
    elsif !@word.include?(str) && !@wrong_guesses.include?(str)
      @wrong_guesses << str
    else
      return false
    end
    return true
  end

  def word_with_guesses
    @word.chars.map { |c| @guesses.include?(c) ? c : '-' }.join
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if word_with_guesses == @word
    return :play
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
