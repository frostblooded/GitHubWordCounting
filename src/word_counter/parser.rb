require 'word_counter/result'
module WordCounter
  # counts words in text
  class Parser
    def initialize
      @extension = ''
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
        removal_regex = /(((['"])(?:(?!\2|\\).|\\.)*\2)|\/\/[^\n]*|\/\*(?:[^*]|\*(?!\/))*\*\/)|[^[[:word:]]\s]/
      else
        removal_regex = /(=begin([^n]|.)*?=end)|(#(?![^"]*"$).*$)|[^[[:word:]]\s]/
      end

      words = string.downcase.gsub(removal_regex, ' ').split(' ').reject(&:empty?)

      # remove numbers, but only those that are ONLY numbers: 0x23 wont match
      words.each do |word|
        words.delete word if word =~ /^[0-9]*$/
      end
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
