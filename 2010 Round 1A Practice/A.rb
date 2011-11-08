# 2010 Round 1A:A Rotate

# Display

def display caseNum, answer
	puts "Case #" << caseNum.to_s << ": " << answer.to_s
end

# Resource

def rotate board
	rotBoard = [][]
	for y in 0...board.size
		for x in 0...board[y].size
			rotBoard[y][x] = board[x][y]
		end
	end
end

def pushRight board

	newBoard = []
	for row in board
		s = String.new(row)
		s.gsub! ".", ""
		newRow = ""
		for i in 0..(board.size - s.size - 1)
			newRow << "."
		end
		newRow << s
		newBoard << newRow
	end

	return newBoard
end

def win? checkString, k, player
	winString = ""
	for i in 0...k
		winString += player
	end

	return true if checkString.include? winString
	return false
end

def joinK board, k

	puts k
	for row in board
		print row
		puts
	end

	bWin = false
	rWin = false

	#Check horizontal
	for row in board
		bWin = true if win? row, k, 'B'
		rWin = true if win? row, k, 'R'
	end

	#Check Vertical
	for x in 0...board[0].size
		checkString = ""
		for row in board
			checkString << row[x]
		end
		bWin = true if win? checkString, k, 'B'
		rWin = true if win? checkString, k, 'R'		
	end

	#Check TL to BR diagonals
	for y in (board.size - 1).downto 0
		checkBotString = ""
		checkTopString = ""
		for x in 0...(board[y].size - y)
			checkBotString << board[x][y - x]
			checkTopString << board[y - x][x]
		end

		bWin = true if win? checkBotString, k, 'B'
		bWin = true if win? checkTopString, k, 'B'
		rWin = true if win? checkBotString, k, 'R'
		rWin = true if win? checkTopString, k, 'R'
	end

	#Check TR to BL diagonals
	for y in 0...board.size
		checkTopString = ""
		checkBotString = ""
		for x in 0...y
			checkTopString << board[x][y - x]
			puts (board.size-1-x).to_s + " " + (board.size - y - x).to_s
			checkBotString << board[board.size - 1 - x][board.size - y]
			puts checkBotString
		end

		#puts checkTopString
		#puts checkBotString

		bWin = true if win? checkBotString, k, 'B'
		bWin = true if win? checkTopString, k, 'B'
		rWin = true if win? checkBotString, k, 'R'
		rWin = true if win? checkTopString, k, 'R'
	end

	return "Both" if bWin == true && rWin == true
	return "Red" if rWin == true
	return "Blue" if bWin == true
	return "Neither"
end

# Solve

def solve board, k
	return joinK (pushRight board), k
end

# Main

CaseCount = gets.chomp.to_i

for caseNum in 1..CaseCount

	nk = gets.chomp.split ' '
	n = nk[0].to_i #n x n board
	k = nk[1].to_i

	board = []
	for y in 0...n
		board[y] = gets.chomp
	end

	if caseNum == 97
		display caseNum, (solve board, k)
	end
end