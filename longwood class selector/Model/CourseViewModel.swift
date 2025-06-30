import Foundation
import SwiftUI

enum SortCriteria {
    case alphabetical, department, credits, availability, courseLevel, meetingTime
}

class RegistrationViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var registeredCourses: [Course] = []
    @Published var waitlistedCourses: [Course] = []
    @Published var currentStudent: Student = Student.sampleStudent
    @Published var selectedDepartment: String?
    @Published var showOpenCoursesOnly: Bool = false
    @Published var sortCriteria: SortCriteria = .alphabetical
    @Published var filterShowing: Bool = true
    @Published var isLoading: Bool = true
    
    init() {
        // Load courses asynchronously to avoid blocking the UI
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            // Prepare the course data using the CourseDataService
            let courseData = CourseDataService.getLongwoodCourses()
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.courses = courseData
                self.isLoading = false
            }
        }
    }
    
    func refreshCourses() {
        // In a real app, this would refresh from the server
        // For demo purposes, we'll just simulate a refresh
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Maybe randomize some enrollments to simulate changes
            for i in 0..<min(5, self.courses.count) {
                let randomIndex = Int.random(in: 0..<self.courses.count)
                var course = self.courses[randomIndex]
                let newEnrollment = min(course.capacity, max(0, course.currentEnrollment + Int.random(in: -2...2)))
                
                // Create an updated course with the new enrollment
                let updatedCourse = Course(
                    courseCode: course.courseCode,
                    title: course.title,
                    instructor: course.instructor,
                    location: course.location,
                    meetingTime: course.meetingTime,
                    meetingDays: course.meetingDays,
                    credits: course.credits,
                    description: course.description,
                    prerequisites: course.prerequisites,
                    department: course.department,
                    semester: course.semester,
                    capacity: course.capacity,
                    currentEnrollment: newEnrollment,
                    isWaitlistAvailable: course.isWaitlistAvailable,
                    courseLevel: course.courseLevel
                )
                
                self.courses[randomIndex] = updatedCourse
            }
        }
    }
    
    // Check if a course's schedule conflicts with registered courses
    func hasScheduleConflict(_ course: Course) -> Course? {
        // Check against all registered courses
        for registeredCourse in registeredCourses {
            // Skip if it's the same course
            if registeredCourse.id == course.id {
                continue
            }
            
            // Check for conflicts between main course times
            if hasTimeConflict(course1: course, course2: registeredCourse, checkLabs: false) {
                print("⚠️ SCHEDULE CONFLICT: \(course.courseCode) conflicts with \(registeredCourse.courseCode)")
                return registeredCourse
            }
            
            // Check for conflicts between course and lab times
            if course.hasLab && hasTimeConflict(course1: course, course2: registeredCourse, checkLabs: true) {
                print("⚠️ LAB SCHEDULE CONFLICT: \(course.courseCode) lab conflicts with \(registeredCourse.courseCode)")
                return registeredCourse
            }
            
            // Check for conflicts between lab times if both courses have labs
            if course.hasLab && registeredCourse.hasLab && hasLabConflict(course1: course, course2: registeredCourse) {
                print("⚠️ LAB-LAB CONFLICT: \(course.courseCode) lab conflicts with \(registeredCourse.courseCode) lab")
                return registeredCourse
            }
        }
        
        return nil
    }
    
    // Helper function to check for time conflicts between courses
    private func hasTimeConflict(course1: Course, course2: Course, checkLabs: Bool) -> Bool {
        // Get meeting days and times
        let (days1, time1) = checkLabs && course1.hasLab 
            ? (course1.labMeetingDays ?? [], course1.labMeetingTime ?? "")
            : (course1.meetingDays, course1.meetingTime)
            
        let (days2, time2) = (course2.meetingDays, course2.meetingTime)
        
        // Check if there's a day overlap
        let dayOverlap = days1.contains { day in
            days2.contains(day)
        }
        
        // If no day overlap, no conflict
        if !dayOverlap {
            return false
        }
        
        // Parse the meeting times
        let timeRange1 = parseTimeRange(time1)
        let timeRange2 = parseTimeRange(time2)
        
        // Check for time overlap
        return doTimesOverlap(timeRange1, timeRange2)
    }
    
    // Helper function to check for conflicts between lab times
    private func hasLabConflict(course1: Course, course2: Course) -> Bool {
        guard course1.hasLab && course2.hasLab,
              let lab1Days = course1.labMeetingDays,
              let lab2Days = course2.labMeetingDays,
              let lab1Time = course1.labMeetingTime,
              let lab2Time = course2.labMeetingTime else {
            return false
        }
        
        // Check if there's a day overlap
        let dayOverlap = lab1Days.contains { day in
            lab2Days.contains(day)
        }
        
        // If no day overlap, no conflict
        if !dayOverlap {
            return false
        }
        
        // Parse the lab meeting times
        let lab1TimeRange = parseTimeRange(lab1Time)
        let lab2TimeRange = parseTimeRange(lab2Time)
        
        // Check for time overlap
        return doTimesOverlap(lab1TimeRange, lab2TimeRange)
    }
    
    // Parse a time string like "10:00 AM - 10:50 AM" into (startMinutes, endMinutes)
    private func parseTimeRange(_ timeString: String) -> (start: Int, end: Int) {
        let components = timeString.components(separatedBy: " - ")
        
        let startMinutes = minutesFromTimeString(components.first ?? "")
        let endMinutes = minutesFromTimeString(components.last ?? "")
        
        return (startMinutes, endMinutes)
    }
    
    // Convert a time string like "10:00 AM" to minutes from midnight
    private func minutesFromTimeString(_ timeString: String) -> Int {
        // Extract time part and AM/PM indicator
        let parts = timeString.components(separatedBy: " ")
        guard parts.count >= 2 else { return 0 }
        
        let timePart = parts[0]
        let periodPart = parts[1].uppercased()
        
        // Parse hours and minutes
        let timePieces = timePart.components(separatedBy: ":")
        guard timePieces.count >= 2,
              let hours = Int(timePieces[0]),
              let minutes = Int(timePieces[1]) else {
            return 0
        }
        
        // Convert to 24-hour format
        var totalHours = hours
        if periodPart == "PM" && hours < 12 {
            totalHours += 12
        } else if periodPart == "AM" && hours == 12 {
            totalHours = 0
        }
        
        // Convert to minutes from midnight
        return totalHours * 60 + minutes
    }
    
    // Check if two time ranges overlap
    private func doTimesOverlap(_ range1: (start: Int, end: Int), _ range2: (start: Int, end: Int)) -> Bool {
        // Time ranges overlap if one range's start is before the other's end
        // and its end is after the other's start
        return range1.start < range2.end && range1.end > range2.start
    }
    
    func isRegistered(for course: Course) -> Bool {
        // Explicitly print ID check to debug
        let found = registeredCourses.contains(where: { $0.id == course.id })
        if found {
            print("🔍 Course \(course.courseCode) IS already registered with ID \(course.id)")
        }
        return found
    }
    
    func registerForCourse(_ course: Course) {
        // HARD CHECK: First verify the course is not already registered
        let alreadyRegistered = registeredCourses.contains(where: { $0.id == course.id })
        
        if alreadyRegistered {
            print("🛑 REJECTED: Already registered for \(course.courseCode) (ID: \(course.id))")
            ToastManager.shared.show(toast: Toast(style: .warning, message: "You are already registered for \(course.courseCode)"))
            return
        }
        
        // Check for schedule conflicts
        if let conflictingCourse = hasScheduleConflict(course) {
            print("🛑 REJECTED: Schedule conflict between \(course.courseCode) and \(conflictingCourse.courseCode)")
            
            // Show a detailed toast notification about the conflict
            let conflictMessage = "Cannot register for \(course.courseCode).\nTime conflict with \(conflictingCourse.courseCode) (\(conflictingCourse.meetingTime))."
            ToastManager.shared.show(toast: Toast(style: .error, message: conflictMessage))
            return
        }
        
        print("✅ REGISTERING: \(course.courseCode) (ID: \(course.id))")
        
        // Add to registered courses
        registeredCourses.append(course)
        
        // Update course enrollment in the courses list
        if let index = courses.firstIndex(where: { $0.id == course.id }) {
            var updatedCourse = courses[index]
            updatedCourse.currentEnrollment += 1
            courses[index] = updatedCourse
        }
        
        // Show success toast
        ToastManager.shared.show(toast: Toast(style: .success, message: "Successfully registered for \(course.courseCode)"))
        
        // Force UI update
        objectWillChange.send()
    }
    
    func dropCourse(_ course: Course) {
        // Check if the course is actually registered
        guard registeredCourses.contains(where: { $0.id == course.id }) else {
            print("🚫 Cannot drop - not registered for \(course.courseCode)")
            return
        }
        
        print("🗑️ DROPPING: \(course.courseCode) (ID: \(course.id))")
        
        // Remove from registered courses
        registeredCourses.removeAll(where: { $0.id == course.id })
        
        // Update course enrollment in the courses list
        if let index = courses.firstIndex(where: { $0.id == course.id }) {
            var updatedCourse = courses[index]
            updatedCourse.currentEnrollment = max(0, updatedCourse.currentEnrollment - 1)
            courses[index] = updatedCourse
        }
        
        // Force UI update
        objectWillChange.send()
    }
    
    // Add a method to replace a course and register for a new one
    func replaceAndRegister(dropCourse: Course, registerCourse: Course) {
        print("🔄 REPLACING: \(dropCourse.courseCode) with \(registerCourse.courseCode)")
        
        // First, drop the existing course
        self.dropCourse(dropCourse)
        
        // Then register for the new course
        // Don't need to check for conflicts since we just removed the conflicting course
        
        // Add to registered courses
        registeredCourses.append(registerCourse)
        
        // Update course enrollment in the courses list
        if let index = courses.firstIndex(where: { $0.id == registerCourse.id }) {
            var updatedCourse = courses[index]
            updatedCourse.currentEnrollment += 1
            courses[index] = updatedCourse
        }
        
        // Show success toast
        ToastManager.shared.show(toast: Toast(
            style: .success, 
            message: "Replaced \(dropCourse.courseCode) with \(registerCourse.courseCode)"
        ))
        
        // Force UI update
        objectWillChange.send()
    }
    
    func resetFilters() {
        selectedDepartment = nil
        showOpenCoursesOnly = false
    }
    
    func isWaitlisted(for course: Course) -> Bool {
        return waitlistedCourses.contains(where: { $0.id == course.id })
    }
    
    func joinWaitlist(for course: Course) {
        // Prevent joining waitlist if already registered or waitlisted
        if isRegistered(for: course) {
            print("🛑 Can't join waitlist - already registered for \(course.courseCode)")
            return
        }
        
        if isWaitlisted(for: course) {
            print("🛑 Already on waitlist for \(course.courseCode)")
            return
        }
        
        // Can only join waitlist for courses that are full and have waitlist available
        if course.isOpen || !course.isWaitlistAvailable {
            print("🛑 Course \(course.courseCode) not eligible for waitlist")
            return
        }
        
        print("📋 Adding to waitlist: \(course.courseCode)")
        waitlistedCourses.append(course)
        
        // Force UI update
        objectWillChange.send()
    }
    
    func removeFromWaitlist(_ course: Course) {
        guard isWaitlisted(for: course) else {
            print("🚫 Cannot remove - not on waitlist for \(course.courseCode)")
            return
        }
        
        print("🗑️ Removing from waitlist: \(course.courseCode)")
        waitlistedCourses.removeAll(where: { $0.id == course.id })
        
        // Force UI update
        objectWillChange.send()
    }
    
    // Filter courses by department for search
    func getDepartments() -> [String] {
        let departments = Set(courses.map { $0.department })
        return Array(departments).sorted()
    }
    
    // Filter courses by course level
    func filterByLevel(level: CourseLevel) -> [Course] {
        return courses.filter { $0.courseLevel == level }
    }
    
    // Add a helper method for checking potential conflicts for a list of courses
    func checkForScheduleConflicts(coursesToCheck: [Course]) -> [(course1: Course, course2: Course)] {
        var conflicts: [(course1: Course, course2: Course)] = []
        
        for i in 0..<coursesToCheck.count {
            for j in (i+1)..<coursesToCheck.count {
                let course1 = coursesToCheck[i]
                let course2 = coursesToCheck[j]
                
                // Check for conflicts between main course times
                if hasTimeConflict(course1: course1, course2: course2, checkLabs: false) {
                    conflicts.append((course1: course1, course2: course2))
                    continue // Skip other checks for this pair since we found a conflict
                }
                
                // Check for conflicts between course1's lab and course2's main time
                if course1.hasLab && hasTimeConflict(course1: course1, course2: course2, checkLabs: true) {
                    conflicts.append((course1: course1, course2: course2))
                    continue
                }
                
                // Check for conflicts between course2's lab and course1's main time
                if course2.hasLab && hasTimeConflict(course1: course2, course2: course1, checkLabs: true) {
                    conflicts.append((course1: course1, course2: course2))
                    continue
                }
                
                // Check for conflicts between lab times if both courses have labs
                if course1.hasLab && course2.hasLab && hasLabConflict(course1: course1, course2: course2) {
                    conflicts.append((course1: course1, course2: course2))
                }
            }
        }
        
        return conflicts
    }
    
    // Helper to show a list of conflicting courses in a user-friendly way
    func getScheduleConflictsDescription(for coursesToCheck: [Course]) -> String {
        let conflicts = checkForScheduleConflicts(coursesToCheck: coursesToCheck)
        
        if conflicts.isEmpty {
            return "No schedule conflicts found."
        }
        
        var description = "Schedule conflicts found:\n"
        for (index, conflict) in conflicts.enumerated() {
            let course1 = conflict.course1
            let course2 = conflict.course2
            
            description += "\(index + 1). \(course1.courseCode) conflicts with \(course2.courseCode)\n"
            
            // Check what kind of conflict this is
            var conflictDetails: [String] = []
            
            // Check main course time conflicts
            if hasTimeConflict(course1: course1, course2: course2, checkLabs: false) {
                conflictDetails.append("Course times: \(course1.meetingTime) vs \(course2.meetingTime)")
            }
            
            // Check lab conflicts
            if course1.hasLab && hasTimeConflict(course1: course1, course2: course2, checkLabs: true) {
                conflictDetails.append("Lab conflict: \(course1.courseCode) lab vs \(course2.courseCode) course")
            }
            
            if course2.hasLab && hasTimeConflict(course1: course2, course2: course1, checkLabs: true) {
                conflictDetails.append("Lab conflict: \(course2.courseCode) lab vs \(course1.courseCode) course")
            }
            
            if course1.hasLab && course2.hasLab && hasLabConflict(course1: course1, course2: course2) {
                conflictDetails.append("Lab-to-lab conflict: \(course1.labMeetingTime ?? "N/A") vs \(course2.labMeetingTime ?? "N/A")")
            }
            
            // Add the most relevant conflict detail
            if let firstDetail = conflictDetails.first {
                description += "   (\(firstDetail))\n"
            }
        }
        
        return description
    }
} 