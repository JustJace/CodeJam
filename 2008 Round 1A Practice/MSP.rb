# Minimum Scalar Product

# Display

def display caseNum, product
	puts "Case #" << caseNum.to_s << ": " << product.to_s
end


# Resource (all these methods are really highest/lowest or 0)

def highestNeg v
	return v.slice! 0
end

def highestPos v
	return v.slice! -1
end

def lowestNeg v

	for i in 0...v.size
		if v[i] > 0
			return v.slice! i-1
		end
	end

	return v.slice! -1
end

def lowestPos v

	for i in (v.size - 1).downto 0
		if v[i] < 0
			return v.slice! i + 1
		end
	end
	return v.slice! 0
end

def hasPos? v
	if v[-1] < 0
		return false
	else
		return true
	end
end

def hasNeg? v
	if v[0] > 0
		return false
	else
		return true
	end
end


# Solve

def solve v1, v2

	product = 0

	while v1.size > 0 && v2.size > 0
		if hasNeg? v1
			if hasPos? v2
				product += highestNeg(v1) * highestPos(v2)
			else
				product += highestNeg(v1) * lowestNeg(v2)
			end
		else
			if hasNeg? v2
				product += highestPos(v1) * highestNeg(v2)
			else
				product += highestPos(v1) * lowestPos(v2)
			end
		end
	end

	return product
end



# main

caseCount = gets.chomp.to_i

for caseNum in 1..caseCount
	cardinality = gets.chomp.to_i
	v1 = []
	v2 = []
	gets.chomp.split(' ').each { |xn| v1 << xn.to_i }
	gets.chomp.split(' ').each { |yn| v2 << yn.to_i }
	v1.sort!
	v2.sort!
	display caseNum, (solve v1, v2)
end