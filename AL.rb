#; Alien Language

# Hash language: -1 = Not There
# => 			  0 = Partial
# => 			  1 = Word
$words = Hash.new(-1)

# Gets the next token whether it's a single char
# or a group of enclosed chars "(abc)"
# removes the () and returns "abc"
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


# Recursive solve method.
# Immediately trims if partial is not in hash
# Returns with a +1 if the hash matches to a full word
# Otherwise it gets the next token and continues the
# brute force solve
def solve(w, g, v)

	if $words[g] == -1
		return v
	elsif $words[g] == 1
		return v + 1
	end
	#else $words[g] == 0

	tkn = next_token(w)	
	for char in tkn.chars
		v = solve(String.new(w), g + char, v)
	end

	return v
end


#; MAIN


LDN = gets.chomp.split(' ')
L = LDN[0].to_i
D = LDN[1].to_i
N = LDN[2].to_i

$words[""] = 0 # Empty string is a partial too

# Adds each word and every substring of that word to hash
for i in 1..D
	word = gets.chomp
	partial = ""
	for char in word.chars
		partial << char
		$words[partial] = 0
	end
	$words[word] = 1
end

# For each case, solve!
for i in 1..N
	tCase = gets.chomp
	ans = solve(tCase, "", 0)
	puts "Case #" << i.to_s << ": " << ans.to_s
end