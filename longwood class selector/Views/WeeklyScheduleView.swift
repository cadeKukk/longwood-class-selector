import SwiftUI

struct WeeklyScheduleView: View {
    let courses: [Course]
    
    private let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    // Adding half-hour time slots for better granularity
    private let timeSlots = ["8:00 AM", "8:30 AM", "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", 
                           "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", 
                           "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM"]
    
    // Cached course time spans to avoid recomputation
    @State private var courseTimeSpans: [String: (startIndex: Int, endIndex: Int)] = [:]
    
    // Check if a course occurs on the specified day
    private func courseIsOnDay(_ course: Course, day: String) -> Bool {
        switch day {
        case "Monday":
            return course.meetingDays.contains(.monday)
        case "Tuesday":
            return course.meetingDays.contains(.tuesday)
        case "Wednesday":
            return course.meetingDays.contains(.wednesday)
        case "Thursday":
            return course.meetingDays.contains(.thursday)
        case "Friday":
            return course.meetingDays.contains(.friday)
        default:
            return false
        }
    }
    
    // Helper to check if a lab occurs on the specified day
    private func labIsOnDay(_ course: Course, day: String) -> Bool {
        guard course.hasLab, let labDays = course.labMeetingDays else {
            return false
        }
        
        switch day {
        case "Monday":
            return labDays.contains(.monday)
        case "Tuesday":
            return labDays.contains(.tuesday)
        case "Wednesday":
            return labDays.contains(.wednesday)
        case "Thursday":
            return labDays.contains(.thursday)
        case "Friday":
            return labDays.contains(.friday)
        default:
            return false
        }
    }
    
    // Extract time info from meeting time string
    private func getTimeInfo(_ meetingTime: String) -> (hour: Int, minute: Int, isAfternoon: Bool) {
        // Look for time patterns like "10:00 AM"
        let components = meetingTime.components(separatedBy: " ")
        if components.count >= 2 {
            let timeComponent = components[0]
            let periodComponent = components[1]
            
            let hourMinute = timeComponent.components(separatedBy: ":")
            if hourMinute.count >= 2, 
               let hour = Int(hourMinute[0]),
               let minute = Int(hourMinute[1]) {
                let isAfternoon = periodComponent == "PM"
                return (hour, minute, isAfternoon)
            }
        }
        
        // Default to morning 9:00
        return (9, 0, false)
    }
    
    // Calculate time spans for all courses
    private func calculateCourseTimeSpans() {
        courseTimeSpans.removeAll()
        
        for course in courses {
            // Calculate course time span
            if let timeSpan = getTimeSpanForCourse(course) {
                courseTimeSpans[course.id] = timeSpan
            }
            
            // Calculate lab time span if course has a lab
            if course.hasLab, let labTime = course.labMeetingTime {
                let labId = "\(course.id)_lab"
                if let timeSpan = getTimeSpanForLabSession(course) {
                    courseTimeSpans[labId] = timeSpan
                }
            }
        }
    }
    
    // Calculate the time span (start and end row indices) for a course
    private func getTimeSpanForCourse(_ course: Course) -> (startIndex: Int, endIndex: Int)? {
        let components = course.meetingTime.components(separatedBy: " - ")
        guard components.count == 2 else { return nil }
        
        let startComponent = components[0]
        let endComponent = components[1]
        
        let (startHour, startMinute, startIsAfternoon) = getTimeInfo(startComponent)
        let (endHour, endMinute, endIsAfternoon) = getTimeInfo(endComponent)
        
        // Convert to minutes since 8:00 AM
        let startTime = convertToMinutesSinceMidnight(hour: startHour, minute: startMinute, isAfternoon: startIsAfternoon)
        let endTime = convertToMinutesSinceMidnight(hour: endHour, minute: endMinute, isAfternoon: endIsAfternoon)
        
        // Find closest time slots
        let startIndex = findNearestTimeSlotIndex(for: startTime)
        let endIndex = findNearestTimeSlotIndex(for: endTime, preferEarlier: false)
        
        return (startIndex, endIndex)
    }
    
    // Calculate time span for lab session
    private func getTimeSpanForLabSession(_ course: Course) -> (startIndex: Int, endIndex: Int)? {
        guard course.hasLab, let labTime = course.labMeetingTime else { return nil }
        
        let components = labTime.components(separatedBy: " - ")
        guard components.count == 2 else { return nil }
        
        let startComponent = components[0]
        let endComponent = components[1]
        
        let (startHour, startMinute, startIsAfternoon) = getTimeInfo(startComponent)
        let (endHour, endMinute, endIsAfternoon) = getTimeInfo(endComponent)
        
        // Convert to minutes since 8:00 AM
        let startTime = convertToMinutesSinceMidnight(hour: startHour, minute: startMinute, isAfternoon: startIsAfternoon)
        let endTime = convertToMinutesSinceMidnight(hour: endHour, minute: endMinute, isAfternoon: endIsAfternoon)
        
        // Find closest time slots
        let startIndex = findNearestTimeSlotIndex(for: startTime)
        let endIndex = findNearestTimeSlotIndex(for: endTime, preferEarlier: false)
        
        return (startIndex, endIndex)
    }
    
    // Convert hour, minute and AM/PM to minutes since midnight
    private func convertToMinutesSinceMidnight(hour: Int, minute: Int, isAfternoon: Bool) -> Int {
        var totalHour = hour
        if isAfternoon && hour < 12 {
            totalHour += 12
        } else if !isAfternoon && hour == 12 {
            totalHour = 0
        }
        
        return totalHour * 60 + minute
    }
    
    // Find nearest time slot index for a time (in minutes since midnight)
    private func findNearestTimeSlotIndex(for minutes: Int, preferEarlier: Bool = true) -> Int {
        // Convert to time string for lookup
        let hour = minutes / 60
        let minute = minutes % 60
        
        // Format as appropriate time string
        var timeString: String
        if hour < 12 {
            timeString = String(format: "%d:%02d AM", hour == 0 ? 12 : hour, minute)
        } else {
            timeString = String(format: "%d:%02d PM", hour == 12 ? 12 : hour - 12, minute)
        }
        
        // Find exact match first
        if let exactIndex = timeSlots.firstIndex(of: timeString) {
            return exactIndex
        }
        
        // Otherwise find closest time slot
        var closestIndex = 0
        var closestDiff = Double.infinity
        
        for (index, slotTimeString) in timeSlots.enumerated() {
            let slotInfo = getTimeInfo(slotTimeString)
            let slotMinutes = convertToMinutesSinceMidnight(
                hour: slotInfo.hour, 
                minute: slotInfo.minute, 
                isAfternoon: slotInfo.isAfternoon)
            
            let diff = abs(slotMinutes - minutes)
            if Double(diff) < closestDiff {
                closestDiff = Double(diff)
                closestIndex = index
            } else if Double(diff) == closestDiff {
                // If two slots are equally close, prefer earlier or later based on parameter
                if preferEarlier {
                    if slotMinutes < minutes {
                        closestIndex = index
                    }
                } else {
                    if slotMinutes > minutes {
                        closestIndex = index
                    }
                }
            }
        }
        
        return closestIndex
    }
    
    // Get courses and labs that should be displayed in a given time slot and day
    private func scheduleCellCoursesForTimeSlot(_ rowIndex: Int, day: String) -> [(course: Course, isLabComponent: Bool, isContinuation: Bool)] {
        var result: [(course: Course, isLabComponent: Bool, isContinuation: Bool)] = []
        
        // Check each course
        for course in courses {
            // Check regular course sessions
            if courseIsOnDay(course, day: day),
               let timeSpan = courseTimeSpans[course.id],
               rowIndex >= timeSpan.startIndex && rowIndex < timeSpan.endIndex {
                
                // For continuation cells (not the first cell in the span)
                let isContinuation = rowIndex > timeSpan.startIndex
                result.append((course: course, isLabComponent: false, isContinuation: isContinuation))
            }
            
            // Also check lab sessions if the course has a lab
            if course.hasLab, 
               labIsOnDay(course, day: day),
               let timeSpan = courseTimeSpans["\(course.id)_lab"],
               rowIndex >= timeSpan.startIndex && rowIndex < timeSpan.endIndex {
                
                // For continuation cells (not the first cell in the span)
                let isContinuation = rowIndex > timeSpan.startIndex
                result.append((course: course, isLabComponent: true, isContinuation: isContinuation))
            }
        }
        
        return result
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                Text("Weekly Schedule")
                    .font(.headline)
                    .padding(.top)
                
                if courses.isEmpty {
                    Text("No courses scheduled")
                        .foregroundColor(LongwoodTheme.subtleText)
                        .padding(.top, 30)
                } else {
                    // Schedule grid
                    VStack(spacing: 0) {
                        // Header row with days
                        HStack(spacing: 0) {
                            // Time column header
                            Text("Time")
                                .font(.caption)
                                .frame(width: 70, height: 40)
                                .background(LongwoodTheme.lightGray)
                                .border(LongwoodTheme.mediumGray, width: 0.5)
                            
                            // Day column headers
                            ForEach(days, id: \.self) { day in
                                Text(day)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .background(LongwoodTheme.lightGray)
                                    .border(LongwoodTheme.mediumGray, width: 0.5)
                            }
                        }
                        
                        // Time rows
                        ForEach(0..<timeSlots.count, id: \.self) { rowIndex in
                            HStack(spacing: 0) {
                                // Time label
                                Text(timeSlots[rowIndex])
                                    .font(.caption2)
                                    .frame(width: 70, height: 60)  // Reduced height for more slots
                                    .background(rowIndex % 2 == 0 ? Color.white : LongwoodTheme.lightGray)
                                    .border(LongwoodTheme.mediumGray, width: 0.5)
                                
                                // Day cells
                                ForEach(days, id: \.self) { day in
                                    ZStack(alignment: .center) {
                                        // Cell background
                                        Rectangle()
                                            .fill(rowIndex % 2 == 0 ? Color.white : LongwoodTheme.lightGray)
                                            .border(LongwoodTheme.mediumGray, width: 0.5)
                                        
                                        // Courses in this time slot and day
                                        let cellCourses = scheduleCellCoursesForTimeSlot(rowIndex, day: day)
                                        
                                        if !cellCourses.isEmpty {
                                            VStack(spacing: 2) {
                                                ForEach(cellCourses, id: \.course.id) { courseEntry in
                                                    if !courseEntry.isContinuation {
                                                        // Only show the full cell for the first timeslot
                                                        ScheduleClassCell(
                                                            course: courseEntry.course,
                                                            isLabComponent: courseEntry.isLabComponent
                                                        )
                                                    } else {
                                                        // For continuation cells, show a more distinct continuation appearance
                                                        VStack(alignment: .leading, spacing: 1) {
                                                            if rowIndex % 2 == 0 { // Only add dots on even rows to avoid clutter
                                                                HStack {
                                                                    Text("•")
                                                                        .font(.caption)
                                                                        .foregroundColor(LongwoodTheme.colorForDepartment(courseEntry.course.department))
                                                                    Spacer()
                                                                }
                                                            }
                                                        }
                                                        .frame(maxWidth: .infinity, minHeight: 20) // Increased height for better visibility
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 4)
                                                                .fill(courseEntry.isLabComponent 
                                                                    ? LongwoodTheme.colorForDepartment(courseEntry.course.department).opacity(0.2)
                                                                    : LongwoodTheme.colorForDepartment(courseEntry.course.department).opacity(0.2))
                                                        )
                                                        .padding(.horizontal, 8)
                                                    }
                                                }
                                            }
                                            .padding(4)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
        }
        .onAppear {
            // Calculate time spans when view appears
            calculateCourseTimeSpans()
        }
    }
}

struct ScheduleClassCell: View {
    let course: Course
    let isLabComponent: Bool
    
    init(course: Course, isLabComponent: Bool = false) {
        self.course = course
        self.isLabComponent = isLabComponent
    }
    
    private var timeDisplay: String {
        if isLabComponent, let labTime = course.labMeetingTime {
            // Extract just the times from lab meeting time
            let components = labTime.components(separatedBy: " - ")
            if components.count >= 2 {
                return "\(components[0])-\(components[1])"
            }
            return labTime
        } else {
            // Extract just the times from regular meeting time
            let components = course.meetingTime.components(separatedBy: " - ")
            if components.count >= 2 {
                return "\(components[0])-\(components[1])"
            }
            return course.meetingTime
        }
    }
    
    private var durationDisplay: String {
        let components = isLabComponent && course.labMeetingTime != nil 
            ? course.labMeetingTime!.components(separatedBy: " - ")
            : course.meetingTime.components(separatedBy: " - ")
            
        if components.count == 2 {
            if let startTime = parseTimeString(components[0]),
               let endTime = parseTimeString(components[1]) {
                let durationMinutes = endTime - startTime
                let hours = durationMinutes / 60
                let minutes = durationMinutes % 60
                
                if hours > 0 {
                    return minutes > 0 ? "\(hours)h \(minutes)m" : "\(hours)h"
                } else {
                    return "\(minutes)m"
                }
            }
        }
        return ""
    }
    
    // Parse a time string like "10:00 AM" to minutes since midnight
    private func parseTimeString(_ timeString: String) -> Int? {
        let components = timeString.components(separatedBy: " ")
        if components.count >= 2 {
            let timePart = components[0]
            let amPmPart = components[1].uppercased()
            
            let timePieces = timePart.components(separatedBy: ":")
            if timePieces.count >= 2, 
               let hours = Int(timePieces[0]), 
               let minutes = Int(timePieces[1]) {
                
                var totalHours = hours
                if amPmPart == "PM" && hours < 12 {
                    totalHours += 12
                } else if amPmPart == "AM" && hours == 12 {
                    totalHours = 0
                }
                
                return totalHours * 60 + minutes
            }
        }
        return nil
    }
    
    private var locationDisplay: String {
        if isLabComponent, let labLocation = course.labLocation {
            return labLocation.components(separatedBy: " ").first ?? ""
        } else {
            return course.location.components(separatedBy: " ").first ?? ""
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(isLabComponent ? "\(course.courseCode) Lab" : course.courseCode)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(1)
            
            HStack(spacing: 4) {
                Text(timeDisplay)
                    .font(.caption2)
                    .foregroundColor(LongwoodTheme.subtleText)
                    .lineLimit(1)
                
                if !durationDisplay.isEmpty {
                    Text("(\(durationDisplay))")
                        .font(.caption2)
                        .foregroundColor(LongwoodTheme.subtleText.opacity(0.7))
                        .lineLimit(1)
                }
            }
                
            Text(locationDisplay)
                .font(.caption2)
                .foregroundColor(LongwoodTheme.subtleText)
                .lineLimit(1)
                
            // Show continuation indicator if class spans multiple time slots
            if hasMultipleTimeSlots() {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.down")
                        .font(.system(size: 10))
                        .foregroundColor(LongwoodTheme.colorForDepartment(course.department))
                }
                .padding(.top, 2)
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(isLabComponent 
                     ? LongwoodTheme.colorForDepartment(course.department).opacity(0.2)
                     : LongwoodTheme.colorForDepartment(course.department).opacity(0.2))
        )
        .overlay(
            isLabComponent ?
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(LongwoodTheme.colorForDepartment(course.department).opacity(0.5), lineWidth: 1)
                : nil
        )
    }
    
    // Check if a course spans multiple time slots
    private func hasMultipleTimeSlots() -> Bool {
        let components = isLabComponent && course.labMeetingTime != nil 
            ? course.labMeetingTime!.components(separatedBy: " - ")
            : course.meetingTime.components(separatedBy: " - ")
            
        if components.count == 2 {
            if let startTime = parseTimeString(components[0]),
               let endTime = parseTimeString(components[1]) {
                // If duration is more than 45 minutes, it likely spans multiple time slots
                let durationMinutes = endTime - startTime
                return durationMinutes > 45
            }
        }
        return false
    }
} 
