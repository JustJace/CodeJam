#; Alien Language

# Hash language: -1 = not there
# => 			  0 = Partial
# => 			  1 = Word
$words = Hash.new(-1)

def next_token(w)
	if w[0] != '('
		return w.slice!(0)
	end

	w.slice!(0) #remove that leading '('

	token = ""
	while true
		c = w.slice!(0)
		if c == ')'
			break
		end

		token << c
	end

	return token
end


def solve(w, g, v)

	if $words[g] == -1
		return v
	elsif $words[g] == 1
		return v + 1
	end
	#else $words[g] == 0

	tkn = next_token(w)
	return v if tkn == "" || tkn == nil
	
	for char in tkn.chars
		v = solve(String.new(w), g + char, v)
	end

	return v
end


#; __MAIN__


LDN = gets.chomp.split(' ')
L = LDN[0].to_i
D = LDN[1].to_i
N = LDN[2].to_i

$words[""] = 0 # Empty string is a partial too
for i in 1..D
	word = gets.chomp
	partial = ""
	for char in word.chars
		partial << char
		$words[partial] = 0
	end

	$words[word] = 1
end

for i in 1..N
	tCase = gets.chomp
	ans = solve(tCase, "", 0)
	puts "Case #" << i.to_s << ": " << ans.to_s
end