# 2010 Round 1B:A File Fix-it


# display

def display caseNum, answer
	puts "Case #" << caseNum.to_s << ": " << answer.to_s
end

# Resource

def parentOf dir

	parent = String.new(dir).reverse
	parent.slice! 0..parent.index('/')
	return parent.reverse
end

# solve

def solve root, mkdirs

	mkdirCount = 0

	for dir in mkdirs
		next if root[dir]
		mkdirCount += 1
		root[dir] = true
		parent = parentOf dir
		while !root[parent]
			mkdirCount += 1
			root[parent] = true
			parent = parentOf parent
		end
	end

	return mkdirCount
end



# main

CaseCount = gets.chomp.to_i

for caseNum in 1..CaseCount

	nm = gets.chomp.split ' '
	existCount = nm[0].to_i
	createCount = nm[1].to_i

	root = Hash.new(false)
	root[""] = true
	for i in 0...existCount
		root[gets.chomp] = true
	end

	mkdirs = []
	for i in 0...createCount
		mkdirs[i] = gets.chomp
	end

	display caseNum, (solve root, mkdirs)
end