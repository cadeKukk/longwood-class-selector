import Foundation
import SwiftUI

class Student: ObservableObject {
    let id: String
    @Published var name: String
    @Published var studentID: String
    @Published var email: String
    @Published var major: String
    @Published var classYear: String
    @Published var advisor: String
    @Published var phoneNumber: String
    @Published var address: String
    @Published var emergencyContact: String
    @Published var emergencyPhone: String
    let timeSlot: String
    let isRegistrationOpen: Bool
    let hasFinancialHold: Bool
    let hasAdvisingHold: Bool
    
    init(id: String, name: String, studentID: String, email: String, major: String, 
         classYear: String, advisor: String, phoneNumber: String, address: String,
         emergencyContact: String, emergencyPhone: String, timeSlot: String,
         isRegistrationOpen: Bool, hasFinancialHold: Bool, hasAdvisingHold: Bool) {
        self.id = id
        self.name = name
        self.studentID = studentID
        self.email = email
        self.major = major
        self.classYear = classYear
        self.advisor = advisor
        self.phoneNumber = phoneNumber
        self.address = address
        self.emergencyContact = emergencyContact
        self.emergencyPhone = emergencyPhone
        self.timeSlot = timeSlot
        self.isRegistrationOpen = isRegistrationOpen
        self.hasFinancialHold = hasFinancialHold
        self.hasAdvisingHold = hasAdvisingHold
    }
    
    // In a real app, these would be more detailed objects with relationships to Course
    var completedCourses: [String] = []
    
    // Check if student can register for a course
    func canRegisterForCourse(_ course: Course) -> Bool {
        // For demonstration purposes, we'll always return true to ensure registration works
        return true
    }
    
    // Helper function to check for schedule conflicts (simplified for demo)
    func hasTimeConflict(_ course: Course) -> Bool {
        // In a real app, we would check if the new course's meeting time
        // overlaps with any already registered courses
        return false
    }
    
    // Helper function to check credit limit (simplified for demo)
    func isAtCreditLimit(_ additionalCredits: Int) -> Bool {
        // In a real app, we would check if adding these credits would exceed 18
        return false
    }
    
    // Sample student data for preview purposes
    static let sampleStudent = Student(
        id: "12345",
        name: "Lancer Student",
        studentID: "L12345678",
        email: "L12345678@longwood.edu",
        major: "Computer Science",
        classYear: "Junior",
        advisor: "Dr. Robert Marmorstein",
        phoneNumber: "",
        address: "",
        emergencyContact: "",
        emergencyPhone: "",
        timeSlot: "April 10, 2025 at 9:00 AM",
        isRegistrationOpen: true,
        hasFinancialHold: false,
        hasAdvisingHold: false
    )
} 