

require 'word_counter'
require_relative 'src/SVG/SVG.rb'

def write_to_file(file, data)
  File.open(file, 'w') do |f|
  f << data
  end
end

def handle_repo_parsing(folder, file_extension, json_res_file, svg_res_file)
  result = WordCounter.parse_folder folder, file_extension

  if result.word_counts.size > 0
    write_to_file json_res_file, result.to_json
    SVGWriter.make_svg result, svg_res_file
  end
end

folder = ARGV[0]

if !File.directory? 'results'
  Dir.mkdir 'results'
end

handle_repo_parsing folder, :rb, "results/ruby.json", "results/ruby.svg"
handle_repo_parsing folder, :cpp, "results/cpp.json", "results/cpp.svg"
handle_repo_parsing folder, :java, "results/java.json", "results/java.svg"
