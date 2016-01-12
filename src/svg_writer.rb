# Creates a SVG bar chart from a sorted counted words hash
class SVGWriter
  @bar_max_height = 500
  @bar_width = 20
  @bar_color = 'rgb(185,129,183)'
  @bars_starting_x = 10
  @bars_starting_y = 50
  @bars_bottom_y = @bars_starting_y + @bar_max_height
  @distance_between_bars = 5
  @word_text_y_bellow_bar = 5
  @count_text_y_above_bar = 20
  @text_color = 'black'

  def self.get_word_rect(single_count_height, word, count, index)
    rect_height = single_count_height * count
    rect_x = @bars_starting_x + (@bar_width + @distance_between_bars) * index
    rect_y = @bars_bottom_y - rect_height
    rectangle = rect(rect_x, \
                     rect_y, \
                     @bar_width, \
                     rect_height)

    word_text = text(rect_x + @bar_width / 2, @bars_bottom_y + @word_text_y_bellow_bar, word)
    rectangle + word_text
  end

  def self.rect(x, y, w, h)
    '<rect x="' + x.to_s + \
      '" y="' + y.to_s + \
      '" width="' + w.to_s + \
      '" height="' + h.to_s + \
      '" fill="' + @bar_color + \
      '"/>'
  end

  def self.text(x, y, str)
    '<text x="' + x.to_s + \
      '" y="' + y.to_s + \
      '" fill="' + @text_color.to_s + \
      '" style="writing-mode: tb;">' + str.to_s + \
      '</text>'
  end

  def self.bar_chart(file, data)
    File.open(file, 'w') do |f|
      hash = data.word_counts

      # hash.values.max is the word with the biggest count
      single_count_height = (@bar_max_height.to_f - 1) / hash.values.max.to_f
      f << '<svg xmlns="http://www.w3.org/2000/svg">'

      hash.each_with_index do |(word, count), index|
        f << get_word_rect(single_count_height, word, count, index)
      end

      f << '</svg>'
    end
  end
end
