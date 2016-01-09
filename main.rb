require 'word_counter'

def write_to_file(file, data)
  File.open(file, 'w') do |f|
    f << data
  end
end

def print_result(result, format)
  puts result.to_json
  write_to_file('svg_res.svg', result.to_svg)
end

folder = ARGV[1]
format = ARGV[2]
result = WordCounter.parse_folder folder
print_result result, format