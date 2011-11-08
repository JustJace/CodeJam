# Code Jam Qualifying Round
# Problem A : Bot Trust


@B = "B"
@O = "O"

# Display

def display time, caseNum
	puts "Case #" << caseNum.to_s << ": " << time.to_s
end


# Solving

def locationOf switch
	return switch[1...switch.size].to_i
end

def colorOf switch
	return switch[0]
end

def colors_next switchs, color
	for i in 0...switchs.size
		return (locationOf switchs[i]) if (colorOf switchs[i]) == color
	end

	return nil
end

def color_move switchs, color, pos
	nextLoc = colors_next switchs, color

	return  0 if nextLoc == nil
	return  0 if nextLoc == pos
	return  1 if nextLoc > pos
	return -1 if nextLoc < pos
end


def solve switchs
	bluePos = 1
	oranPos = 1
	time = 0

	while switchs.size > 0
		currentSwitch = switchs[0]
		time += 1

		if ((colorOf currentSwitch) == @O) && ((locationOf currentSwitch) == oranPos)
			switchs.slice! 0
		else
			oranPos += color_move switchs, @O, oranPos
		end

		break if switchs.size == 0

		if ((colorOf currentSwitch) == @B) && ((locationOf currentSwitch) == bluePos)
			switchs.slice! 0
		else
			bluePos += color_move switchs, @B, bluePos
		end

	end

	return time

end

# Main

caseCount = gets.chomp.to_i

for i in 1..caseCount
	line = gets.chomp.split ' '
	switchCount = line[0].to_i
	switchs = []
	for c in 0...switchCount
		switchs[c] = line[2 * c + 1] + line[2 * c + 2]
	end

	display (solve switchs), i
end