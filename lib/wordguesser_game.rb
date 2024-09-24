class WordGuesserGame

  attr_accessor :word, :guesses, :wrong_guesses


  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end


  def guess(letter)

    raise ArgumentError if letter.nil? || letter.empty? || !letter.match?(/[a-zA-Z]/)

    letter = letter.downcase


    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)


    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end

    true
  end


  def word_with_guesses
    if @guesses.empty?

      return '-' * @word.length
    else

      @word.gsub(/[^#{@guesses}]/, '-')
    end
  end


  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif @word.chars.all? { |char| @guesses.include?(char) }
      :win
    else
      :play
    end
  end


  def self.get_random_word
    require 'net/http'
    require 'uri'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.post(uri, "").body
  end
end
