# 2011 Round 1B:B

# Display

def display caseNum, answer
	puts "Case #" << caseNum.to_s << ": " << answer.to_s
end

# Resource

def midpoint vendorLocations

	return (vendorLocations.max - vendorLocations.min) / 2.0

end

# Solve

def solve vendorLocations, distance

	maxTime = 0.0
	vendorCount = vendorLocations.size
	distanceToSpan = (vendorCount - 1.0) * distance.to_f
	midPoint = midpoint vendorLocations

	nextPoint = midPoint - (distanceToSpan.to_f / 2.0)
	for vendor in vendorLocations
		distanceToTravel = (nextPoint - vendor).abs
		#puts "Vendor at " + vendor.to_s + " must travel " + distanceToTravel.to_s + " to reach the next point at " + nextPoint.to_s
		if distanceToTravel > maxTime
			maxTime = distanceToTravel
		end
		nextPoint += distance
	end

	return maxTime
end


# Main

CaseCount = gets.chomp.to_i

for caseNum in 1..CaseCount

	cd = gets.chomp.split ' '
	vendorPoints = cd[0].to_i
	distance = cd[1].to_f
	vendorList = []
	for c in 0...vendorPoints

		pv = gets.chomp.split ' '
		point = pv[0].to_i
		vendorsAtPoint = pv[1].to_i

		for vendor in 0...vendorsAtPoint
			vendorList << point
		end
	end

	display caseNum, (solve vendorList, distance)
end