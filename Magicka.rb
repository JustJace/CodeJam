# Code Jam Qualifying Round
# Problem B : Magicka

# Display

def display caseNum, invoked
	invokeOut = invoked.to_s
	# Formats to the required output
	invokeOut.gsub! "\"", ""
	puts "Case #" << caseNum.to_s << ": " << invokeOut
end

# Solve

def hasOpps oppHash, invoked, nextElem

	for char in invoked.chars
		if oppHash[char + nextElem] != nil
			return true
		end
	end

	return false
end


def solve elements, coms, opps

	comHash = Hash.new(nil)
	for com in coms
		baseOne = com[0]
		baseTwo	= com[1]
		newElem = com[2]
		comHash[baseOne + baseTwo] = newElem
		comHash[baseTwo + baseOne] = newElem
	end

	oppHash = Hash.new(nil)
	for opp in opps
		baseOne = opp[0]
		baseTwo = opp[1]
		oppHash[baseOne + baseTwo] = ""
		oppHash[baseTwo + baseOne] = ""
	end

	invoked = ""
	
	while elements.size > 0
		nextElem = elements.slice! 0

		# Check for combination
		if (invoked.size > 0) && (comHash[invoked[-1] + nextElem] != nil)
			invoked << comHash[invoked.slice!(-1) + nextElem]
		elsif hasOpps oppHash, invoked, nextElem
			invoked = ""
		else
			invoked << nextElem
		end
	end 

	return invoked.chars.to_a
end

# Main

caseCount = gets.chomp.to_i

for caseNum in 1..caseCount

	tCase = gets.chomp.split ' '

	coms = []
	comCount = tCase.slice! 0
	for c in 0...comCount.to_i
		coms[c] = tCase.slice! 0
	end

	opps = []
	oppCount = tCase.slice! 0
	for p in 0...oppCount.to_i
		opps[p] = tCase.slice! 0
	end

	elementCount = tCase.slice! 0

	elements = tCase.slice! 0

	display caseNum, (solve elements, coms, opps)
end
