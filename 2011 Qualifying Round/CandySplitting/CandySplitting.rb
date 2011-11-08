# Code Jam Qualifying Round
# Problem C : Candy Splitting

require 'set'

# Display

def display caseNum, seanValue
	seanOut = (seanValue == 0 ? "NO" : seanValue.to_s)
	puts "Case #" << caseNum.to_s << ": " << seanOut
end

# Solve

def intToBin val
	return val.to_s(2)
end

def strToDec val
	return val.to_i(2)
end

def patrSum candies

	binSum = "0"

	for candie in candies

		binCan = intToBin candie
		binCan.reverse!

		binNewSum = ""

		for digit in 0...(binSum.size > binCan.size ? binSum.size : binCan.size)

			sumDigit = "0"
			canDigit = "0"
			if binSum[digit] != nil
				sumDigit = binSum[digit]
			else
				sumDigit = "0"
			end

			if binCan[digit] != nil
				canDigit = binCan[digit]
			else
				canDigit = "0"
			end

			binNewSum << "0" if (sumDigit == "0" && canDigit == "0") || (sumDigit == "1" && canDigit == "1")
			binNewSum << "1" if (sumDigit == "1" && canDigit == "0") || (sumDigit == "0" && canDigit == "1")

		end

		binSum = binNewSum
	end

	binSum.reverse!
	return strToDec binSum

end

def seanSum candies

	sum = 0
	for candie in candies
		sum += candie
	end

	return sum
end

def solve candies

	for i in 1...(candies.size/2 + 1)

		maxSeanSum = 0

		for p in candies.combination(i)

			patr = p
			sean = candies.dup
			patr.each { |x| sean.delete_at sean.index(x) }

			if ( (seanSum sean) > maxSeanSum) && ( (patrSum sean) == (patrSum patr) )
				maxSeanSum = seanSum sean
			end
		end

		if maxSeanSum != 0
			return maxSeanSum
		end
	end

	return 0
end

# Main

caseCount = gets.chomp.to_i

for caseNum in 1..caseCount

	candieCount = gets.chomp.to_i
	line = gets.chomp.split ' '
	candies = []
	for c in 0...candieCount
		candies[c] = line[c].to_i
	end

	candies.sort!

	display caseNum, (solve candies)
end