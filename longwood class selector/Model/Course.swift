import Foundation

enum Weekday: Int, Codable {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
}

struct Course: Identifiable {
    let id: String // Explicit ID based on course code
    let courseCode: String         // e.g., "CMSC 140"
    let title: String              // e.g., "Introduction to Programming"
    let instructor: String         // e.g., "Dr. Jane Smith"
    let location: String           // e.g., "Rotunda Hall 302"
    let meetingTime: String        // e.g., "10:00 AM - 10:50 AM"
    let meetingDays: [Weekday]     // e.g., [.monday, .wednesday, .friday]
    let credits: Int               // e.g., 3
    let description: String        // Course description
    let prerequisites: [String]    // List of prerequisite course codes
    let department: String         // e.g., "Computer Science"
    let semester: String           // e.g., "Fall 2025"
    let capacity: Int              // Maximum enrollment
    var currentEnrollment: Int     // Current number of enrolled students
    let isWaitlistAvailable: Bool  // Whether a waitlist is available
    let courseLevel: CourseLevel   // Freshman, Sophomore, etc.
    let hasLab: Bool               // Whether the course includes a lab component
    let labMeetingTime: String?    // Lab meeting time (if applicable)
    let labMeetingDays: [Weekday]? // Lab meeting days (if applicable)
    let labLocation: String?       // Lab location (if applicable)
    
    // Computed properties
    var availableSeats: Int {
        max(0, capacity - currentEnrollment)
    }
    
    var isOpen: Bool {
        availableSeats > 0
    }
    
    // Helper property to determine if this is a 75-minute class (1 hour and 15 minutes)
    var is75MinuteClass: Bool {
        // Parse the meeting time to check duration
        let components = meetingTime.components(separatedBy: " - ")
        if components.count == 2 {
            let startTime = parseTimeString(components[0])
            let endTime = parseTimeString(components[1])
            
            if let start = startTime, let end = endTime {
                // Calculate duration in minutes
                let durationMinutes = end - start
                return durationMinutes >= 70 && durationMinutes <= 80 // ~75 min with some margin
            }
        }
        return false
    }
    
    // Helper method to parse a time string like "10:00 AM" to minutes since midnight
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
    
    // Initialize with explicit ID
    init(courseCode: String, title: String, instructor: String, location: String, 
         meetingTime: String, meetingDays: [Weekday], credits: Int, description: String, 
         prerequisites: [String], department: String, semester: String, capacity: Int, 
         currentEnrollment: Int, isWaitlistAvailable: Bool, courseLevel: CourseLevel = .unknown,
         hasLab: Bool = false, labMeetingTime: String? = nil, labMeetingDays: [Weekday]? = nil,
         labLocation: String? = nil) {
        
        self.id = courseCode // Use courseCode as the stable ID
        self.courseCode = courseCode
        self.title = title
        self.instructor = instructor
        self.location = location
        self.meetingTime = meetingTime
        self.meetingDays = meetingDays
        self.credits = credits
        self.description = description
        self.prerequisites = prerequisites
        self.department = department
        self.semester = semester
        self.capacity = capacity
        self.currentEnrollment = currentEnrollment
        self.isWaitlistAvailable = isWaitlistAvailable
        self.courseLevel = courseLevel
        self.hasLab = hasLab
        self.labMeetingTime = labMeetingTime
        self.labMeetingDays = labMeetingDays
        self.labLocation = labLocation
    }
}

enum CourseLevel: String, Codable {
    case freshman = "Freshman"
    case sophomore = "Sophomore"
    case junior = "Junior"
    case senior = "Senior"
    case graduate = "Graduate"
    case unknown = "Unknown"
    
    static func fromCourseNumber(_ number: Int) -> CourseLevel {
        switch number {
        case 100...199: return .freshman
        case 200...299: return .sophomore
        case 300...399: return .junior
        case 400...499: return .senior
        case 500...999: return .graduate
        default: return .unknown
        }
    }
} 