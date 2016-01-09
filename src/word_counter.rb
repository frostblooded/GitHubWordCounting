require 'word_counter/folder_parser'

# Handles word counting
module WordCounter
  def self.parse_folder(folder)
  	FolderParser.new.parse folder
  end
end
