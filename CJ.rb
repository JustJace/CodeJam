# Welcome to Code Jam

$WCJ = "welcome to code jam"

def solve word, ind, val

	# if index ever reaches the max, it scores
	if ind == $WCJ.size
		return val + 1
	end

	# Otherwise we need to find and solve 
	# all the next chars = $WCJ[ind]
	# in word at or beyond pos
	while (pos = word.index $WCJ[ind] ) != nil
		word = word[(pos + 1)...word.size]
		val = solve(word, ind + 1, val)
	end
	return val
end

def fix i
	s = i.to_s
	if s.size >= 4
		return s[0..4]
	end

	while s.size != 4
		s = "0" + s
	end

	return s
end

N = gets.chomp.to_i

for i in 1..N
	line = gets.chomp
	puts "Case #" << i.to_s << ": " << fix(solve(line, 0, 0))
end