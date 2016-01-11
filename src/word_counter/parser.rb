require 'word_counter/result'
#(?![^"]*").*$
module WordCounter
  # counts words in text
  class Parser
    def initialize
      @extension = ""
    end

    def count_marks(string)
      string.downcase.scan(/[^[[:word:]]0-9_\s]/).count
    end

    def count_words(words)
      res = Hash.new 0

      words.each do |word|
        res[word] += 1
      end

      res
    end

    def sort_counted_words(result_hash)
      result_hash.sort_by { |word, count| [-count, word] }.to_h
    end

    def split_words(string)
      # the regex on the next line removes commented text, strings, regex
      # and any other symbol that isn't a word
      if @extension == :cpp || @extension == :cc || @extension == :java
        removal_regex = /(((['"])(?:(?!\2|\\).|\\.)*\2)|\/\/[^\n]*|\/\*(?:[^*]|\*(?!\/))*\*\/)|[^[[:word:]]\s]|[[:digit:]]/
      else
        removal_regex = /(=begin([^n]|.)*?=end)|(#(?![^"]*"$).*$)|[^[[:word:]]\s]|[[:digit:]]/
      end

      string.downcase.gsub(removal_regex, ' ').split(' ').reject(&:empty?)
    end

    def parse(string, extension)
      @extension = extension
      result = Result.new
      result.marks_count = count_marks string
      words = split_words string
      result.word_counts = count_words words
      result.word_counts = sort_counted_words result.word_counts
      result
    end
  end
end
