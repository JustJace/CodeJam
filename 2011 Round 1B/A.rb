# 2011 Round 1B:A

# Display

def display caseNum, rpiList
	puts "Case #" << caseNum.to_s << ":"
	puts rpiList
end

# Resource

def RPI wp, owp, oowp
	return (0.25 * wp) + (0.50 * owp) + (0.25 * oowp)
end

def WP team, schedule, opponent
	played = 0.0
	won = 0.0
	for i in 0...schedule[team].size
		next if i == opponent
		char = schedule[team][i]
		if char == "1"
			won += 1.0
			played += 1.0
		elsif char == "0"
			played += 1.0
		end
	end

	return 0.0 if played == 0.0
	return won / played
end

def OWP team, schedule
	wpList = []
	count = 0.0
	total = 0.0
		
	for opponent in 0...schedule.size
		next if opponent == team
		next if schedule[team][opponent] == "."
		count += 1.0
		total += (WP opponent, schedule, team)
	end

	return 0 if count == 0.0
	return (total.to_f / count.to_f)
end

def OOWP team, schedule, owpList
	teamCount = 0.0
	owpTotal = 0.0
	for i in 0...owpList.size
		next if i == team
		next if schedule[team][i] == "."
		teamCount += 1.0
		owpTotal += owpList[i]
	end

	return 0.0 if teamCount == 0.0
	return owpTotal.to_f / teamCount.to_f
end

# Solve

def solve schedule
	wpList = []
	for team in 0...schedule.size
		wpList << (WP team, schedule, -1)
	end

	owpList = []
	for team in 0...schedule.size
		owpList << (OWP team, schedule)
	end

	oowpList = []
	for team in 0...schedule.size
		oowpList << (OOWP team, schedule, owpList)
	end

	rpiList = []
	for i in 0...schedule.size
		rpiList << (RPI wpList[i], owpList[i], oowpList[i])
	end

	return rpiList
end


# Main

CaseCount = gets.chomp.to_i

for caseNum in 1..CaseCount

	numTeams = gets.chomp.to_i
	schedule = []
	for y in 0...numTeams
		schedule << gets.chomp
	end

	display caseNum, (solve schedule)
end