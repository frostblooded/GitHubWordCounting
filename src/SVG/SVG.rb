require 'json'

class SVGWriter
  def self.rect  x, y, width, height
    '<rect width="'+width.to_s+'" y ="'+y.to_s+'" x ="'+x.to_s+'" height="'+height.to_s+'" style="fill:rgb(185,129,183); stroke-width:2; stroke:rgb(121,71,119)"/>'
  end

  def self.make_svg(data, file)
    word_counts = data.word_counts
    return if word_counts.size == 0

    File.open(file, "w") do |f|
      f.write('<svg xmlns="http://www.w3.org/2000/svg">')

      temp = word_counts.first.last
      y = temp
      temp = temp / 500 + 1   
      x = 30
      word_counts.each do |word, amount|
        if amount.is_a? Numeric
          temp_y = y
          bar_height = temp * amount * 10
          f.write(rect(x,temp_y, 10, bar_height))
          f.write('<text x = "'+(x + 5).to_s+'" y = "'+(temp_y + bar_height + 10).to_s+'" fill="black" style="writing-mode: tb;">'+word+'</text>')
          x += 20
         else 
          amount.each do |word2, amount2|
            temp_y = y
            bar_height = temp * amount2 * 10
            f.write(rect(x, temp_y, 10, bar_height))
            f.write('<text x = "'+(x + 5).to_s+'" y = "'+(temp_y - 70 + bar_height + 10).to_s+'" fill="black" style="writing-mode: tb;">'+word2+'</text>')
            x += 20
          end 
        end
      end
      f.write('</svg>')
    end
  end
end