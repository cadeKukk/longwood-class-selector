import SwiftUI

struct CourseDetailView: View {
    let course: Course
    let isRegistered: Bool
    let isWaitlisted: Bool
    var onRegister: () -> Void
    var onDrop: () -> Void
    var onWaitlist: () -> Void
    var conflictingCourse: Course? = nil
    var onReplace: ((Course) -> Void)? = nil
    var onViewSchedule: (() -> Void)? = nil
    
    @Environment(\.dismiss) private var dismiss
    @State private var showingActionAlert = false
    @State private var showingSuccessAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var successMessage = ""
    
    // Format meeting days for display
    private var daysDisplay: String {
        let dayAbbreviations = course.meetingDays.map { weekday in
            switch weekday {
            case .monday: return "Monday"
            case .tuesday: return "Tuesday"
            case .wednesday: return "Wednesday"
            case .thursday: return "Thursday"
            case .friday: return "Friday"
            }
        }.joined(separator: ", ")
        
        // Add lab days if they exist and are different
        if course.hasLab, let labDays = course.labMeetingDays, labDays != course.meetingDays {
            let labAbbreviations = labDays.map { weekday in
                switch weekday {
                case .monday: return "Monday"
                case .tuesday: return "Tuesday"
                case .wednesday: return "Wednesday"
                case .thursday: return "Thursday"
                case .friday: return "Friday"
                }
            }.joined(separator: ", ")
            return "\(dayAbbreviations) + Lab: \(labAbbreviations)"
        }
        
        return dayAbbreviations
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: LongwoodTheme.defaultPadding) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(course.courseCode)
                            .font(.headline)
                            .foregroundColor(LongwoodTheme.subtleText)
                        
                        Spacer()
                        
                        // Registration status indicator
                        if isRegistered {
                            HStack(spacing: 4) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(LongwoodTheme.success)
                                
                                Text("Registered")
                                    .font(.subheadline)
                                    .foregroundColor(LongwoodTheme.success)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(LongwoodTheme.success.opacity(0.1))
                            )
                        } else if isWaitlisted {
                            HStack(spacing: 4) {
                                Image(systemName: "person.3.sequence.fill")
                                    .foregroundColor(LongwoodTheme.warning)
                                
                                Text("Waitlisted")
                                    .font(.subheadline)
                                    .foregroundColor(LongwoodTheme.warning)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(LongwoodTheme.warning.opacity(0.1))
                            )
                        } else if conflictingCourse != nil {
                            HStack(spacing: 4) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(LongwoodTheme.error)
                                
                                Text("Schedule Conflict")
                                    .font(.subheadline)
                                    .foregroundColor(LongwoodTheme.error)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(LongwoodTheme.error.opacity(0.1))
                            )
                        }
                        
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(LongwoodTheme.subtleText)
                        }
                    }
                    
                    Text(course.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: 16) {
                        // Credits pill
                        HStack(spacing: 4) {
                            Text("\(course.credits)")
                                .fontWeight(.semibold)
                            Text(course.credits > 1 ? "credits" : "credit")
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(LongwoodTheme.primaryBlue.opacity(0.1))
                        )
                        .foregroundColor(LongwoodTheme.primaryBlue)
                        
                        // Status pill
                        HStack(spacing: 6) {
                            Circle()
                                .fill(course.isOpen ? LongwoodTheme.success : LongwoodTheme.error)
                                .frame(width: 8, height: 8)
                            
                            Text(course.isOpen ? "Open" : "Closed")
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(course.isOpen ? LongwoodTheme.success.opacity(0.1) : LongwoodTheme.error.opacity(0.1))
                        )
                        .foregroundColor(course.isOpen ? LongwoodTheme.success : LongwoodTheme.error)
                        
                        Spacer()
                    }
                    
                    // Schedule conflict warning
                    if let conflict = conflictingCourse, !isRegistered {
                        HStack(spacing: 6) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(LongwoodTheme.error)
                                .font(.caption)
                            
                            VStack(alignment: .leading) {
                                Text("Schedule Conflict")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(LongwoodTheme.error)
                                
                                Text("This course conflicts with \(conflict.courseCode) (\(conflict.meetingTime))")
                                    .font(.caption)
                                    .foregroundColor(LongwoodTheme.subtleText)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(LongwoodTheme.error.opacity(0.1))
                        .cornerRadius(LongwoodTheme.cornerRadius)
                        .padding(.top, 8)
                    }
                }
                
                Divider()
                
                // Course Details - In a card
                VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
                    Text("Course Details")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    DetailRow(icon: "person.fill", title: "Instructor", value: course.instructor)
                    DetailRow(icon: "mappin.and.ellipse", title: "Location", value: course.location)
                    DetailRow(icon: "clock", title: "Meeting Time", value: course.meetingTime)
                    DetailRow(icon: "calendar.badge.clock", title: "Meeting Days", value: daysDisplay)
                    DetailRow(icon: "building.2", title: "Department", value: course.department)
                    DetailRow(icon: "calendar", title: "Semester", value: course.semester)
                    
                    HStack {
                        DetailRow(icon: "person.3", title: "Enrollment", value: "\(course.currentEnrollment)/\(course.capacity)")
                        
                        Spacer()
                        
                        // Seats available indicator
                        Text("\(course.availableSeats) seats available")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(course.isOpen ? LongwoodTheme.success.opacity(0.1) : LongwoodTheme.error.opacity(0.1))
                            )
                            .foregroundColor(course.isOpen ? LongwoodTheme.success : LongwoodTheme.error)
                    }
                }
                .padding(LongwoodTheme.defaultPadding)
                .background(
                    RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                        .fill(LongwoodTheme.lightGray)
                )
                
                // Course Description
                VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
                    Text("Description")
                        .font(.headline)
                    
                    Text(course.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(4)
                }
                
                // Prerequisites
                if !course.prerequisites.isEmpty {
                    VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
                        Text("Prerequisites")
                            .font(.headline)
                        
                        ForEach(course.prerequisites, id: \.self) { prerequisite in
                            HStack(alignment: .top, spacing: 8) {
                                Text("•")
                                    .foregroundColor(LongwoodTheme.primaryBlue)
                                Text(prerequisite)
                                    .font(.body)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                
                Spacer(minLength: 30)
                
                // Registration Button
                Button(action: {
                    if isRegistered {
                        showingActionAlert = true
                        alertTitle = "Drop Course"
                        alertMessage = "Are you sure you want to drop \(course.title)?"
                    } else if isWaitlisted {
                        showingActionAlert = true
                        alertTitle = "Leave Waitlist"
                        alertMessage = "Are you sure you want to leave the waitlist for \(course.title)?"
                    } else if conflictingCourse != nil {
                        showingActionAlert = true
                        alertTitle = "Schedule Conflict"
                        alertMessage = "This course conflicts with \(conflictingCourse!.courseCode) (\(conflictingCourse!.meetingTime)). What would you like to do?"
                    } else {
                        if course.availableSeats > 0 {
                            onRegister()
                            showingSuccessAlert = true
                        } else {
                            showingActionAlert = true
                            alertTitle = "Course is Full"
                            alertMessage = "This course has no available seats. Would you like to join the waitlist?"
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: buttonIcon)
                            .animation(.spring(), value: isRegistered || isWaitlisted)
                        Text(buttonText)
                            .animation(.spring(), value: isRegistered || isWaitlisted)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(LongwoodTheme.cornerRadius)
                    .animation(.spring(), value: buttonColor)
                }
                .disabled((course.availableSeats == 0 && !course.isWaitlistAvailable && !isRegistered && !isWaitlisted) || (conflictingCourse != nil && !isRegistered && !isWaitlisted && onReplace == nil))
                .padding(.horizontal)
                .padding(.bottom)
                
                if isRegistered {
                    Text("You are currently registered for this course.")
                        .font(.subheadline)
                        .foregroundColor(LongwoodTheme.success)
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding(LongwoodTheme.defaultPadding)
        }
        .navigationBarItems(trailing: Button(action: {
            dismiss()
        }) {
            Text("Done")
                .foregroundColor(LongwoodTheme.primaryBlue)
        })
        .alert(isPresented: $showingActionAlert) {
            if conflictingCourse != nil && !isRegistered && !isWaitlisted {
                return Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("View Schedule")) {
                        if let viewSchedule = onViewSchedule {
                            viewSchedule()
                            dismiss()
                        }
                    },
                    secondaryButton: .destructive(Text("Replace \(conflictingCourse?.courseCode ?? "")")) {
                        if let conflict = conflictingCourse, let replace = onReplace {
                            replace(conflict)
                            successMessage = "Replaced \(conflict.courseCode) with \(course.title)."
                            showingSuccessAlert = true
                        }
                    }
                )
            } else {
                return Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    primaryButton: .default(Text(isRegistered ? "Drop" : isWaitlisted ? "Leave Waitlist" : "Join Waitlist")) {
                        if isRegistered {
                            onDrop()
                            successMessage = "You've successfully dropped \(course.title)."
                            showingSuccessAlert = true
                            dismiss()
                        } else if isWaitlisted {
                            onDrop()
                            successMessage = "You've been removed from the waitlist for \(course.title)."
                            showingSuccessAlert = true
                            dismiss()
                        } else {
                            onWaitlist()
                            successMessage = "You've been added to the waitlist for \(course.title)."
                            showingSuccessAlert = true
                            dismiss()
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .alert("Success", isPresented: $showingSuccessAlert) {
            Button("OK", role: .cancel) { 
                dismiss()
            }
        } message: {
            Text(successMessage)
        }
    }
    
    private var buttonColor: Color {
        if isRegistered {
            return LongwoodTheme.error
        } else if isWaitlisted {
            return LongwoodTheme.error
        } else if conflictingCourse != nil {
            return LongwoodTheme.error
        } else if course.availableSeats == 0 {
            return course.isWaitlistAvailable ? LongwoodTheme.warning : LongwoodTheme.mediumGray
        } else {
            return LongwoodTheme.primaryBlue
        }
    }
    
    private var buttonText: String {
        if isRegistered {
            return "Drop Course"
        } else if isWaitlisted {
            return "Leave Waitlist"
        } else if conflictingCourse != nil {
            return "Schedule Conflict"
        } else if course.availableSeats == 0 {
            return course.isWaitlistAvailable ? "Join Waitlist" : "Course Full"
        } else {
            return "Register"
        }
    }
    
    private var buttonIcon: String {
        if isRegistered || isWaitlisted {
            return "minus.circle"
        } else if conflictingCourse != nil {
            return "exclamationmark.triangle"
        } else {
            return "plus.circle"
        }
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(LongwoodTheme.subtleText)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(LongwoodTheme.subtleText)
                
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    let sampleViewModel = RegistrationViewModel()
    let sampleCourse = sampleViewModel.courses.first!
    return CourseDetailView(
        course: sampleCourse,
        isRegistered: false,
        isWaitlisted: false,
        onRegister: {},
        onDrop: {},
        onWaitlist: {}
    )
} 