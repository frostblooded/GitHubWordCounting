require 'word_counter'
require_relative 'src/SVG/SVG.rb'

folder = ARGV[0]
result = WordCounter.parse_folder folder
puts result.to_json
SVGWriter.make_svg(result, "result.svg")