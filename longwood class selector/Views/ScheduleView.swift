import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @State private var selectedCourse: Course? = nil
    // The course whose details sheet is open. Kept apart from selectedCourse,
    // which the Remove Course alert also uses.
    @State private var detailCourse: Course? = nil
    @State private var showingRemoveAlert = false
    
    private let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    // Define time slots from 8 AM to 8 PM
    private let timeSlots = ["8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", 
                           "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM", "7:00 PM", "8:00 PM"]
    
    // Time range constants for precise positioning
    private let startHourMinutes = 8 * 60  // 8:00 AM in minutes since midnight
    private let endHourMinutes = 20 * 60   // 8:00 PM in minutes since midnight
    private let totalDisplayMinutes = 12 * 60 // 12 hours displayed
    private let cellHeight: CGFloat = 80
    
    var body: some View {
        mainContentView
            .navigationTitle("My Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $detailCourse, onDismiss: {
                // Force refresh when sheet is dismissed to ensure view updates
                viewModel.objectWillChange.send()
            }) { course in
                Group {
                    CourseDetailView(
                        course: course,
                        isRegistered: viewModel.isRegistered(for: course),
                        isWaitlisted: viewModel.isWaitlisted(for: course),
                        onRegister: {
                            if viewModel.isRegistered(for: course) {
                                print("⚠️ Attempted to register for a course that's already registered")
                            } else if let conflictingCourse = viewModel.hasScheduleConflict(course) {
                                print("⚠️ Schedule conflict detected with \(conflictingCourse.courseCode)")
                            } else {
                                viewModel.registerForCourse(course)
                            }
                        },
                        onDrop: {
                            if viewModel.isRegistered(for: course) {
                                print("Attempting to drop \(course.courseCode) from schedule view")
                                viewModel.dropCourse(course)
                            } else if viewModel.isWaitlisted(for: course) {
                                print("Attempting to remove \(course.courseCode) from waitlist")
                                viewModel.removeFromWaitlist(course)
                            }
                            // Dismiss sheet after action
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                detailCourse = nil
                            }
                        },
                        onWaitlist: {
                            if !viewModel.isRegistered(for: course) && !viewModel.isWaitlisted(for: course) {
                                viewModel.joinWaitlist(for: course)
                            }
                        },
                        conflictingCourse: viewModel.hasScheduleConflict(course),
                        onReplace: { conflictingCourse in
                            viewModel.replaceAndRegister(dropCourse: conflictingCourse, registerCourse: course)
                            detailCourse = nil
                        }
                    )
                }
            }
            .alert(isPresented: $showingRemoveAlert) {
                Alert(
                    title: Text("Remove Course"),
                    message: Text("Are you sure you want to remove \(selectedCourse?.courseCode ?? "") - \(selectedCourse?.title ?? "") from your schedule?"),
                    primaryButton: .destructive(Text("Remove")) {
                        if let course = selectedCourse {
                            viewModel.dropCourse(course)
                        }
                        selectedCourse = nil
                    },
                    secondaryButton: .cancel {
                        selectedCourse = nil
                    }
                )
            }
    }
    
    private var mainContentView: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header showing credit count
                creditInfoHeader
                
                if viewModel.isLoading {
                    loadingView
                } else if viewModel.registeredCourses.isEmpty && viewModel.waitlistedCourses.isEmpty {
                    emptyScheduleView
                } else {
                    VStack(spacing: 0) {
                        // Schedule grid (if there are registered courses)
                        if !viewModel.registeredCourses.isEmpty {
                            scheduleGridContent
                        }
                        
                        // Waitlist section (if there are waitlisted courses)
                        if !viewModel.waitlistedCourses.isEmpty {
                            waitlistSection
                        }
                    }
                }
            }
        }
    }
    
    private var creditInfoHeader: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Schedule")
                        .font(.headline)
                    
                    Text("\(totalCredits) credits • \(viewModel.registeredCourses.count) courses")
                        .font(.subheadline)
                        .foregroundColor(LongwoodTheme.subtleText)
                }
                
                Spacer()
            }
            
            // Show conflict warning if conflicts exist
            if !scheduleConflicts.isEmpty {
                conflictWarningView
            }
        }
        .padding(.horizontal, LongwoodTheme.defaultPadding)
        .padding(.top, LongwoodTheme.smallPadding)
        .padding(.bottom, LongwoodTheme.smallPadding)
        .background(Color.white)
    }
    
    private var scheduleGridView: some View {
        ScrollView {
            scheduleGridContent
        }
    }
    
    private var scheduleGridContent: some View {
        ZStack(alignment: .topLeading) {
            // Stable background grid - this never changes
            VStack(spacing: 0) {
                dayHeaderRow
                backgroundTimeGrid
            }
            
            // Course overlay - positioned over the stable grid with precise positioning
            VStack(spacing: 0) {
                // Spacer for header row
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 40)
                
                // Course positions with precise time-based positioning
                courseOverlayGrid
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 16)
    }
    
    private var waitlistSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Waitlist header
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Waitlisted Courses")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("\(viewModel.waitlistedCourses.count) \(viewModel.waitlistedCourses.count == 1 ? "course" : "courses") on waitlist")
                            .font(.subheadline)
                            .foregroundColor(LongwoodTheme.subtleText)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.3.sequence.fill")
                        .font(.title2)
                        .foregroundColor(LongwoodTheme.warning)
                }
                
                Text("You'll be notified when a spot becomes available")
                    .font(.caption)
                    .foregroundColor(LongwoodTheme.subtleText)
            }
            .padding(.horizontal, LongwoodTheme.defaultPadding)
            .padding(.top, LongwoodTheme.defaultPadding)
            
            // Waitlist cards
            LazyVStack(spacing: 8) {
                ForEach(viewModel.waitlistedCourses) { course in
                    WaitlistCourseCard(
                        course: course,
                        onRemove: {
                            viewModel.removeFromWaitlist(course)
                        },
                        onViewDetails: {
                            detailCourse = course
                        }
                    )
                }
            }
            .padding(.horizontal, LongwoodTheme.defaultPadding)
            .padding(.bottom, LongwoodTheme.defaultPadding)
        }
        .background(LongwoodTheme.lightGray.opacity(0.3))
    }
    
    private var dayHeaderRow: some View {
        HStack(spacing: 0) {
            // Time column header
            Text("Time")
                .font(.caption)
                .fontWeight(.medium)
                .frame(width: 60, height: 40)
                .background(LongwoodTheme.lightGray)
                .border(LongwoodTheme.mediumGray, width: 0.5)
            
            // Day column headers
            ForEach(days, id: \.self) { day in
                Text(day.prefix(3))
                    .font(.caption)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(LongwoodTheme.lightGray)
                    .border(LongwoodTheme.mediumGray, width: 0.5)
            }
        }
    }
    
    // Stable background grid that never changes size
    private var backgroundTimeGrid: some View {
        ForEach(0..<timeSlots.count, id: \.self) { rowIndex in
            HStack(spacing: 0) {
                // Time label - always 80 points high
                VStack {
                    Text(timeSlots[rowIndex])
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(LongwoodTheme.darkGray)
                        .padding(.top, 4)
                    Spacer()
                }
                .frame(width: 60, height: cellHeight) // Fixed height
                .background(rowIndex % 2 == 0 ? Color.white : LongwoodTheme.lightGray.opacity(0.3))
                .border(LongwoodTheme.mediumGray, width: 0.5)
                
                // Day cells - always consistent size
                ForEach(days, id: \.self) { day in
                    Rectangle()
                        .fill(rowIndex % 2 == 0 ? Color.white : LongwoodTheme.lightGray.opacity(0.3))
                        .border(LongwoodTheme.mediumGray, width: 0.5)
                        .frame(maxWidth: .infinity, minHeight: cellHeight, maxHeight: cellHeight) // Fixed height
                }
            }
        }
    }
    
    // Course overlay with precise positioning based on actual times
    private var courseOverlayGrid: some View {
        HStack(spacing: 0) {
            // Time column spacer
            Rectangle()
                .fill(Color.clear)
                .frame(width: 60, height: CGFloat(timeSlots.count) * cellHeight)
            
            // Day columns with precise course positioning
            ForEach(days, id: \.self) { day in
                coursesForDay(day)
            }
        }
    }
    
    // Generate all courses for a specific day with precise positioning
    private func coursesForDay(_ day: String) -> some View {
        ZStack(alignment: .topLeading) {
            // Transparent background that maintains grid structure
            Rectangle()
                .fill(Color.clear)
                .frame(maxWidth: .infinity)
                .frame(height: CGFloat(timeSlots.count) * cellHeight)
            
            // All courses for this day
            ForEach(getCoursesForDay(day), id: \.course.id) { entry in
                let position = calculateCoursePosition(for: entry.course, isLab: entry.isLab)
                let courseHeight = calculateCourseHeight(for: entry.course, isLab: entry.isLab)
                
                CourseCell(
                    course: entry.course,
                    isLabComponent: entry.isLab,
                    spanHeight: courseHeight
                )
                .padding(.horizontal, 1)
                .offset(y: position)
                .allowsHitTesting(true)
                .onTapGesture {
                    detailCourse = entry.course
                }
                .contextMenu {
                    Button(action: {
                        detailCourse = entry.course
                    }) {
                        Label("View Details", systemImage: "info.circle")
                    }
                    
                    Button(action: {
                        selectedCourse = entry.course
                        showingRemoveAlert = true
                    }) {
                        Label("Remove Course", systemImage: "trash")
                    }
                }
            }
        }
    }
    
    private var emptyScheduleView: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 70))
                .foregroundColor(LongwoodTheme.lightGray)
            
            Text("No Classes Scheduled")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(LongwoodTheme.darkGray)
            
            Text("You haven't registered for any classes yet. Check out the course catalog to find classes to register for.")
                .font(.body)
                .foregroundColor(LongwoodTheme.subtleText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            NavigationLink(destination: CourseListView(viewModel: viewModel)) {
                HStack {
                    Image(systemName: "plus")
                    Text("Browse Course Catalog")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                        .fill(LongwoodTheme.primaryBlue)
                )
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .padding(.bottom, 10)
            
            Text("Loading schedule...")
                .font(.headline)
                .foregroundColor(LongwoodTheme.subtleText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
    // Get all courses for a specific day (both regular and lab components)
    private func getCoursesForDay(_ day: String) -> [(course: Course, isLab: Bool)] {
        guard let weekday = weekdayFromString(day) else { return [] }
        
        var results: [(course: Course, isLab: Bool)] = []
        
        for course in viewModel.registeredCourses {
            // Check regular course meeting time
            if course.meetingDays.contains(weekday) {
                results.append((course: course, isLab: false))
                print("✅ Found course \(course.courseCode) on \(day)")
            }
            
            // Check lab meeting time if it exists
            if course.hasLab, 
               let labDays = course.labMeetingDays,
               labDays.contains(weekday) {
                results.append((course: course, isLab: true))
                print("✅ Found lab \(course.courseCode) on \(day)")
            }
        }
        
        return results
    }
    
    // Calculate precise vertical position based on start time
    private func calculateCoursePosition(for course: Course, isLab: Bool) -> CGFloat {
        let timeString = isLab && course.hasLab 
            ? course.labMeetingTime ?? course.meetingTime
            : course.meetingTime
        
        let components = timeString.components(separatedBy: " - ")
        guard components.count == 2 else { return 0 }
        
        let startTime = components[0].trimmingCharacters(in: .whitespaces)
        guard let startMinutes = parseTimeToMinutes(startTime) else {
            print("⚠️ Failed to parse start time for \(course.courseCode): \(startTime)")
            return 0
        }
        
        // Calculate position using discrete time slots for better alignment
        let minutesFromStart = startMinutes - startHourMinutes
        
        // Find which time slot this course should align with
        let slotIndex = minutesFromStart / 60  // Which hour slot (0-based)
        let minutesIntoSlot = minutesFromStart % 60  // Minutes past the hour
        
        // Position at the start of the appropriate time slot, plus offset for minutes
        let basePosition = CGFloat(slotIndex) * cellHeight
        let minuteOffset = (CGFloat(minutesIntoSlot) / 60.0) * cellHeight
        let position = basePosition + minuteOffset
        
        print("📍 Course \(course.courseCode): starts at \(startTime) → slot \(slotIndex), offset \(minutesIntoSlot)min → position \(position) points")
        
        return max(position, 0)
    }
    
    // Calculate course height based on actual duration
    private func calculateCourseHeight(for course: Course, isLab: Bool) -> CGFloat {
        let timeString = isLab && course.hasLab 
            ? course.labMeetingTime ?? course.meetingTime
            : course.meetingTime
        
        let components = timeString.components(separatedBy: " - ")
        guard components.count == 2 else { return 60 }
        
        let startTime = components[0].trimmingCharacters(in: .whitespaces)
        let endTime = components[1].trimmingCharacters(in: .whitespaces)
        
        guard let startMinutes = parseTimeToMinutes(startTime),
              let endMinutes = parseTimeToMinutes(endTime) else {
            print("⚠️ Failed to parse time for \(course.courseCode): \(timeString)")
            return 60
        }
        
        let durationMinutes = endMinutes - startMinutes
        
        // Calculate height using slot-based scaling for consistency with positioning
        let pixelsPerMinute = cellHeight / 60.0  // Each cell represents 60 minutes
        let calculatedHeight = CGFloat(durationMinutes) * pixelsPerMinute
        
        // Minimal padding for visual accuracy
        let finalHeight = max(calculatedHeight - 1, 50)
        
        print("📏 Course \(course.courseCode): \(durationMinutes) min → \(finalHeight) points (expected end: \(endTime))")
        
        return finalHeight
    }
    
    // Parse time string like "10:00 AM" to minutes since midnight
    private func parseTimeToMinutes(_ timeString: String) -> Int? {
        let components = timeString.components(separatedBy: " ")
        guard components.count >= 2 else { return nil }
        
        let timePart = components[0]
        let amPm = components[1].uppercased()
        
        let timePieces = timePart.components(separatedBy: ":")
        guard timePieces.count >= 2,
              let hours = Int(timePieces[0]),
              let minutes = Int(timePieces[1]) else { return nil }
        
        var totalHours = hours
        if amPm == "PM" && hours < 12 {
            totalHours += 12
        } else if amPm == "AM" && hours == 12 {
            totalHours = 0
        }
        
        return totalHours * 60 + minutes
    }
    
    // Helper method to convert day string to weekday enum
    private func weekdayFromString(_ dayString: String) -> Weekday? {
        switch dayString {
        case "Monday": return .monday
        case "Tuesday": return .tuesday
        case "Wednesday": return .wednesday
        case "Thursday": return .thursday
        case "Friday": return .friday
        default: return nil
        }
    }
    
    private var totalCredits: Int {
        viewModel.registeredCourses.reduce(0) { $0 + $1.credits }
    }
    
    // Computed property to check for schedule conflicts
    private var scheduleConflicts: [(course1: Course, course2: Course)] {
        viewModel.checkForScheduleConflicts(coursesToCheck: viewModel.registeredCourses)
    }
    
    // View for showing schedule conflicts
    private var conflictWarningView: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(LongwoodTheme.error)
                
                Text("Schedule Conflicts Detected")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(LongwoodTheme.error)
                
                Spacer()
                
                Button(action: {
                    // Show detailed conflicts in a toast
                    ToastManager.shared.show(toast: Toast(
                        style: .warning,
                        message: viewModel.getScheduleConflictsDescription(for: viewModel.registeredCourses)
                    ))
                }) {
                    Text("See Details")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(LongwoodTheme.error.opacity(0.1))
                        .foregroundColor(LongwoodTheme.error)
                        .cornerRadius(4)
                }
            }
            
            // Show first conflict as an example
            if let firstConflict = scheduleConflicts.first {
                Text("\(firstConflict.course1.courseCode) conflicts with \(firstConflict.course2.courseCode)")
                    .font(.caption)
                    .foregroundColor(LongwoodTheme.subtleText)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LongwoodTheme.error.opacity(0.1))
        .cornerRadius(LongwoodTheme.cornerRadius)
    }
}

// Extension for safe array access
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// Custom course cell for the schedule view
struct CourseCell: View {
    let course: Course
    let isLabComponent: Bool
    let spanHeight: CGFloat
    
    init(course: Course, isLabComponent: Bool = false, spanHeight: CGFloat = 74) {
        self.course = course
        self.isLabComponent = isLabComponent
        self.spanHeight = spanHeight
    }
    
    private var timeDisplay: String {
        if isLabComponent, let labTime = course.labMeetingTime {
            // Extract just the times from lab meeting time
            let components = labTime.components(separatedBy: " - ")
            if components.count >= 2 {
                return "\(components[0])-\(components[1])"
            }
            return "Lab: \(labTime)"
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
    
    private var daysDisplay: String {
        let days = isLabComponent && course.labMeetingDays != nil 
            ? course.labMeetingDays!
            : course.meetingDays
        
        return days.map { weekday in
            switch weekday {
            case .monday: return "M"
            case .tuesday: return "T"
            case .wednesday: return "W"
            case .thursday: return "R"
            case .friday: return "F"
            }
        }.joined(separator: "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(isLabComponent ? "\(course.courseCode) Lab" : course.courseCode)
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                if isLabComponent {
                    Image(systemName: "flask.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            
            HStack(spacing: 4) {
                Text(timeDisplay)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(1)
                
                if !durationDisplay.isEmpty {
                    Text("(\(durationDisplay))")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(1)
                }
            }
            
            // Days of the week display
            HStack(spacing: 2) {
                Text(daysDisplay)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                
                Spacer()
            }
                
            HStack {
                Text(locationDisplay)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(1)
                
                Spacer()
            }
            
            // Add spacing for longer blocks
            if spanHeight > 100 {
                Spacer()
            }
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .frame(maxWidth: .infinity, minHeight: spanHeight, maxHeight: spanHeight, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(isLabComponent 
                      ? LongwoodTheme.colorForDepartment(course.department).opacity(0.8)
                      : LongwoodTheme.colorForDepartment(course.department))
        )
        .overlay(
            isLabComponent ?
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(Color.white.opacity(0.5), lineWidth: 1.5)
                : nil
        )
        .foregroundColor(.white)
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

// Waitlist course card for the schedule view
struct WaitlistCourseCard: View {
    let course: Course
    let onRemove: () -> Void
    let onViewDetails: () -> Void
    
    @State private var showingRemoveAlert = false
    
    // Format meeting days for display
    private var daysDisplay: String {
        course.meetingDays.map { weekday in
            switch weekday {
            case .monday: return "M"
            case .tuesday: return "T"
            case .wednesday: return "W"
            case .thursday: return "R"
            case .friday: return "F"
            }
        }.joined(separator: "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Course header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(course.courseCode)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(course.title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                // Department pill
                Text(course.department)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(LongwoodTheme.colorForDepartment(course.department))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(LongwoodTheme.colorForDepartment(course.department).opacity(0.1))
                    )
            }
            
            // Course details
            HStack(spacing: 12) {
                // Time and days
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                            .foregroundColor(LongwoodTheme.subtleText)
                        
                        Text(course.meetingTime)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption2)
                            .foregroundColor(LongwoodTheme.subtleText)
                        
                        Text(daysDisplay)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // Credits
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(course.credits)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(course.credits == 1 ? "credit" : "credits")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            // Instructor and location
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "person.fill")
                        .font(.caption2)
                        .foregroundColor(LongwoodTheme.subtleText)
                    
                    Text(course.instructor)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption2)
                        .foregroundColor(LongwoodTheme.subtleText)
                    
                    Text(course.location)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            // Action buttons
            HStack(spacing: 8) {
                Button(action: onViewDetails) {
                    HStack(spacing: 4) {
                        Image(systemName: "info.circle")
                            .font(.caption)
                        
                        Text("Details")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(LongwoodTheme.primaryBlue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LongwoodTheme.primaryBlue.opacity(0.1))
                    )
                }
                
                Spacer()
                
                Button(action: {
                    showingRemoveAlert = true
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "minus.circle")
                            .font(.caption)
                        
                        Text("Leave Waitlist")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(LongwoodTheme.error)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LongwoodTheme.error.opacity(0.1))
                    )
                }
            }
            .padding(.top, 4)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(LongwoodTheme.warning.opacity(0.3), lineWidth: 1)
        )
        .onTapGesture {
            onViewDetails()
        }
        .alert(isPresented: $showingRemoveAlert) {
            Alert(
                title: Text("Leave Waitlist"),
                message: Text("Are you sure you want to leave the waitlist for \(course.courseCode) - \(course.title)?"),
                primaryButton: .destructive(Text("Leave Waitlist")) {
                    onRemove()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    ScheduleView(viewModel: RegistrationViewModel())
} 