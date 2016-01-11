require 'word_counter/file_parser'

module WordCounter
  # Parses files
  class FolderParser < FileParser
    def parse(folder, extension)
      files = Dir.glob("#{folder}/**/*").select { |f| File.file? f }
      result = WordCounter::Result.new

      files.each do |file|
        temp = super file, extension
        result.word_counts.merge!(temp.word_counts.to_h) { |_, oldval, newval| newval + oldval }
        result.marks_count += temp.marks_count
      end

      result.word_counts = result.word_counts.sort_by { |word, count| [-count, word] }.to_h
      result
    end
  end
end
