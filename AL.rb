#; Alien Language

$words = ""

def next_token(w)
	if w[0] != '('
		return w.slice!(0)
	end

	token = ""
	while true
		c = w.slice!(0)
		if c == ')'
			break
		end

		token += c
	end

	return token
end


def solve(w, g, v)

	if !$words.include?('|' + g)
		return v
	elsif $words.include?('|' + g + '|')
		return v + 1
	end

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

for i in 1..D
	$words += '|' + gets.chomp
end
$words += '|'

for i in 1..N
	tCase = gets.chomp
	ans = solve(tCase, "", 0)
	puts "Case #" + i.to_s + ": " + ans.to_s
end