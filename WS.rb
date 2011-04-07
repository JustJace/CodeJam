# Watersheds

# Displays the array in grid format
def display solution
	for i in 0...solution.size
		for j in 0...solution[0].size
			print solution[i][j] + ' '
		end
		if i != solution.size - 1
			puts
		end
	end
end

# Returns the next unused letter in the solution
def next_unused_letter sol

	x = 'a'.ord

	for i in 0...sol.size
		for j in 0...sol[0].size
			if sol[i][j].ord > x
				x = sol[i][j].ord
			end
		end
	end

	return (x + 1).chr
end

# Determines where to go next - ties broken in order of: North > West > East > South
def next_path map, h, w

	if (h - 1 < 0)
		hasNorth = false
	else
		hasNorth = true
		nh = h - 1
		nw = w
	end

	if (w - 1 < 0)
		hasWest = false
	else
		hasWest = true
		wh = h
		ww = w - 1
	end
	
	if (w + 1 >= map[0].size)
		hasEast = false
	else
		hasEast = true
		eh = h
		ew = w + 1
	end

	if (h + 1 >= map.size)
		hasSouth = false
	else
		hasSouth = true
		sh = h + 1
		sw = w
	end

	center = map[h][w].to_i
	north = map[nh][nw].to_i if hasNorth
	west = map[wh][ww].to_i if hasWest
	east = map[eh][ew].to_i if hasEast
	south = map[sh][sw].to_i if hasSouth

	low = center
	lh = h
	lw = w

	if hasNorth && north < low
		low = north
		lh = nh
		lw = nw
	end
	if hasWest && west < low
		low = west
		lh = wh
		lw = ww
	end
	if hasEast && east < low
		low = east
		lh = eh
		lw = ew
	end
	if hasSouth && south < low
		low = south
		lh = sh
		lw = sw
	end

	return lh, lw
end

# Checks the solution to see if it's put a letter in each cell
def solved sol
	for i in 0...sol.size
		for j in 0...sol[i].size
			if sol[i][j].ord < 'a'.ord
				return false
			end
		end
	end

	return true
end

# Returns the next point Left to Right, Top To Bottom
def next_point sol
	for i in 0...sol.size
		for j in 0...sol[i].size
			if sol[i][j].ord < 'a'.ord
				return i, j
			end
		end
	end

	return nil, nil
end

# Recursive method for traversing from a cell
def traverse map, sol, x, y, l

	# First lets see if this cell has a letter
	if sol[x][y].ord >= 'a'.ord
		#if it does, then we can just return that letter, and we're done with this traverse path
		return sol[x][y]
	end

	# Otherwise lets set the letter
	sol[x][y] = l

	# Then we're getting the next path (looking at the map)
	a, b = next_path map, x, y

	# If it's the same coords, we're in a sink
	if a == x && b == y
		# If we're in a sink, we can just return the letter it's become
		return sol[x][y]
	end

	# Otherwise it's not a sink, so let's go traversing
	# the new coords and trap the letter it brings back
	new_l = traverse map, sol, a, b, l
	# If it's brought back a new letter, we'll set it now
	sol[x][y] = new_l
	# And we'll return it for the rest of the path, where we came from
	return new_l

end


# Sets up solution grid and begins solving
def solve map

	# Ridic. work around to get a 'deep copy' of the array
	solution = Marshal.load( Marshal.dump(map) )
	letter = 'a'

	while !solved solution
		x,y = next_point solution
		traverse map, solution, x, y, letter
		letter = next_unused_letter solution
	end

	return solution
end


# MAIN

T = gets.chomp.to_i

for i in 1..T

	hw = gets.chomp.split ' '
	h = hw[0].to_i
	w = hw[1].to_i

	map = []
	for j in 0...h
		map.push gets.chomp.split ' '
	end

	puts "Case #" + i.to_s + ":"
	display solve map
	puts
end
