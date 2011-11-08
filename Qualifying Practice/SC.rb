# Store Credit


def solve c, prices

	
end

N = gets.chomp.to_i

for n in 1..N
	c = gets.chomp.to_i
	i = gets.chomp.to_i
	items = gets.chomp.split ' '
	prices = []
	for m in 0..i
		prices << items[m].to_i
	end

	print "Case #" + n.to_s + ": "
	puts solve c, prices

end