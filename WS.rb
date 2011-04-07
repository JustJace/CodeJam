#; Watersheds

def display solution
	for i in 0...solution.size
		for j in 0...solution[0].size
			print solution[i][j] + ' '
		end
		if i != solution.size - 1
			puts
		end
	end
	puts
	puts "------"
end

def next_letter x
	return (x.ord + 1).chr
end

#; Determines where to go next - ties broken in order of: North > West > East > South
def next_path map, h, w

	center = map[h][w]
	nh = h - 1 < 0 ? h : h - 1
	nw = w

	wh = h
	ww = w - 1 < 0 ? w : w - 1

	eh = h
	ew = w + 1 >= map[0].size ? w : w + 1

	sh = h + 1 >= map.size ? h : h + 1
	sw = w

	north = map[nh][nw]
	west = map[wh][ww]
	east = map[eh][ew]
	south = map[sh][sw]

	low = center
	lh = h
	lw = w

	if north < center
		lh = nh
		lw = nw
	end
	if north < center && west < north
		lh = wh
		lw = ww
	end
	if north < center && west < north && east < west
		lh = eh
		lw = ew
	end
	if north < center && west < north && east < west && south < east
		lh = sh
		lw = sw
	end

	return lh, lw
end

def solved sol
	for i in 0..sol.size
		for j in 0..sol[i].size
			if sol[i][j].ord < 'a'.ord
				return false
			end
		end
	end

	return true
end

def next_point sol
	for i in 0..sol.size
		for j in 0..sol[i].size
			if sol[i][j].ord < 'a'.ord
				return i, j
			end
		end
	end

	return nil, nil
end

def traverse map, sol, x, y, l
	#; First we're setting the letter
	sol[x][y] = l

	#; Then we're getting the next path (looking at the map)
	a, b = next_path map, x, y

	#; If it's the same coords, it's a sink
	if a == x && b == y
		#; So we'll decide what letter it should be and return that up

		#; It's not been set
		if sol[x][y].ord < 'a'.ord
			sol[x][y] = l #; Set it
			return l #; return it
		#; Else it has a letter already, we're going to use it for this path
		else 
			return sol[x][y]
		end
	end

	#; Otherwise it's not a sink, so let's go traversing
	#; the new coords and trap the letter it brings back
	new_l = traverse sol, a, b, l
	#; If it's brought back a new letter, we'll set it now
	sol[x][y] = new_l
	#; And we'll return it for the rest of the path, hopefully
	return new_l

end

def solve map

	solution = Array.new map
	letter = 'a'

	while !solved solution
		letter = next_letter letter
		x,y = next_point solution
		traverse map, solution, x, y, letter
	end

	return solution
end


#; MAIN

T = gets.chomp.to_i

for i in 1..1

	hw = gets.chomp.split ' '
	h = hw[0].to_i
	w = hw[1].to_i

	map = []
	for j in 0...h
		map.push gets.chomp.split ' '
	end

	puts "Case #" + i.to_s + ":"
	display solve map
end
