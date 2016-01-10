require 'json' # библиотека 

file = File.read(ARGV[0]) # отваря файла за четене
@word_counts = JSON.parse(file) # парсва хеша от файла


def rect  x, y, width, height
	'<rect width="'+width.to_s+'" y ="'+y.to_s+'" x ="'+x.to_s+'" height="'+height.to_s+'" style="fill:rgb(185,129,183); stroke-width:2; stroke:rgb(121,71,119)"/>'
end



File.open("result.svg", "w") do |f|
	f.write('<svg xmlns="http://www.w3.org/2000/svg">')

	temp = @word_counts.first.last
	y = temp
	temp = temp / 200 + 1 
	x = 40
        @word_counts.each do |word, amount|
        if amount.is_a? Numeric
	   	temp_y = (300 - y) - y
	   	f.write(rect(x,temp_y, 30, temp * amount * 10))
	    f.write('<text x = "'+(x + 10).to_s+'" y = "'+(temp_y - 70).to_s+'" textLength = "'+(word.length * 15).to_s+'" fill="black" style="writing-mode: tb;">'+word+'</text>')
	   	x += 60

	   else 
	   	amount.each do |word2, amount2|
	   		temp_y = (300- y) - y
	   		f.write(rect(x, temp_y, 30, temp * amount2 * 10))
	    	f.write('<text x = "'+(x + 10).to_s+'" y = "'+(temp_y - 70).to_s+'" textLength = "'+(word.length * 15).to_s+'" fill="black" style="writing-mode: tb;">'+word2+'</text>')
	   		x += 60
			end	
		end
	end
	f.write('</svg>')
end


=begin

трябва да парснеш json файла,
да си напишеш функциите за правоъгълници и
текст и после просто като минаваш през всеки 
елемент от хеша му казваш да прави функцията за
правоъгълниците като първият аргумент 
ти е ключът(думата), а вторият е броят на думата

компилиране: ruby + името на файла.rb + името на json файла

=end



=begin
@word_counts.each do |word, amount| # amount = броят на думата
		if amount.is_a? Numeric
			x = 10
			y = amount * 10 + 100
			f.write(graph(amount, x, y));
			f.write(text(x, y, word));
			x += 60
				
			f.write(graph(amount, x, y))
			f.write(text(x, y, word))
		else 
			amount.each do |word2, amount2|
				x = 10
				y = amount2 * 10 + 100
				f.write(graph(amount2, x, y));
				f.write(text(x, y, word2));
				x += 60
				
				f.write(graph(amount2, x, y))
				f.write(text(x, y, word2))
=end