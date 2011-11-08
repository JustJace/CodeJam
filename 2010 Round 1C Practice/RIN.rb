# 2010 Round 1C:A Rope Intranet

# display

def display caseNum, xtions
	puts "Case #" << caseNum.to_s << ": " << xtions.to_s
end

# Resource

def intersect? w1, w2
	return true if (w1[0] >= w2[0] && w1[1] <= w2[1]) || (w1[0] <= w2[0] && w1[1] >= w2[1])
	return false
end

# solve


def solve wires

	xCount = 0

	for i in 0...wires.count
		for j in (i + 1)...wires.count
			xCount += 1 if intersect? wires[i], wires[j]
		end
	end

	return xCount

end

# main

CaseCount = gets.chomp.to_i

for caseNum in 1..CaseCount

	wireCount = gets.chomp.to_i
	wires = []
	for w in 0...wireCount
		wire = []
		gets.chomp.split(' ').each { |h| wire << h.to_i}
		wires << wire
	end

	display caseNum, (solve wires)
end