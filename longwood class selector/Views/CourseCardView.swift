import SwiftUI

struct CourseCardView: View {
    let course: Course
    let isRegistered: Bool
    let isWaitlisted: Bool
    var onRegister: () -> Void
    var onDrop: () -> Void
    var onWaitlist: () -> Void
    var hasTimeConflict: Bool
    var conflictingCourse: Course? = nil
    var onReplace: ((Course) -> Void)? = nil
    var onViewSchedule: (() -> Void)? = nil
    
    @State private var showingActionAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingSuccessAlert = false
    @State private var successMessage = ""
    
    // Format meeting days for display
    private var daysDisplay: String {
        let dayAbbreviations = course.meetingDays.map { weekday in
            switch weekday {
            case .monday: return "M"
            case .tuesday: return "T"
            case .wednesday: return "W"
            case .thursday: return "R"
            case .friday: return "F"
            }
        }.joined(separator: "")
        
        // Add lab days if they exist and are different
        if course.hasLab, let labDays = course.labMeetingDays, labDays != course.meetingDays {
            let labAbbreviations = labDays.map { weekday in
                switch weekday {
                case .monday: return "M"
                case .tuesday: return "T"
                case .wednesday: return "W"
                case .thursday: return "R"
                case .friday: return "F"
                }
            }.joined(separator: "")
            return "\(dayAbbreviations) + Lab: \(labAbbreviations)"
        }
        
        return dayAbbreviations
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
            // Course header
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(course.courseCode)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("\(course.credits)")
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                        
                        Text(course.credits > 1 ? "credits" : "credit")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Text(course.title)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Divider()
                .padding(.vertical, 4)
            
            // Course info section
            VStack(alignment: .leading, spacing: 8) {
                InfoRow(icon: "person.fill", text: course.instructor)
                InfoRow(icon: "mappin.and.ellipse", text: course.location)
                InfoRow(icon: "clock", text: course.meetingTime)
                InfoRow(icon: "calendar", text: daysDisplay)
            }
            
            // Status indicators
            HStack {
                // Department pill
                Text(course.department)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(LongwoodTheme.colorForDepartment(course.department))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(LongwoodTheme.colorForDepartment(course.department).opacity(0.1))
                    )
                
                Spacer()
                
                // Registration status indicator
                if isRegistered {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(LongwoodTheme.success)
                            .font(.caption)
                        
                        Text("Registered")
                            .font(.caption)
                            .foregroundColor(LongwoodTheme.success)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(LongwoodTheme.success.opacity(0.1))
                    )
                } else if isWaitlisted {
                    HStack(spacing: 4) {
                        Image(systemName: "person.3.sequence.fill")
                            .foregroundColor(LongwoodTheme.warning)
                            .font(.caption)
                        
                        Text("Waitlisted")
                            .font(.caption)
                            .foregroundColor(LongwoodTheme.warning)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(LongwoodTheme.warning.opacity(0.1))
                    )
                } else if hasTimeConflict {
                    // Time conflict indicator
                    HStack(spacing: 4) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(LongwoodTheme.error)
                            .font(.caption)
                        
                        Text("Time Conflict")
                            .font(.caption)
                            .foregroundColor(LongwoodTheme.error)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(LongwoodTheme.error.opacity(0.1))
                    )
                } else if !course.isOpen && course.isWaitlistAvailable {
                    // Waitlist availability indicator
                    HStack(spacing: 4) {
                        Image(systemName: "person.3.sequence.fill")
                            .foregroundColor(LongwoodTheme.warning)
                            .font(.caption)
                        
                        Text("Waitlist Available")
                            .font(.caption)
                            .foregroundColor(LongwoodTheme.warning)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(LongwoodTheme.warning.opacity(0.1))
                    )
                } else {
                    // Seats indicator
                    HStack(spacing: 4) {
                        Circle()
                            .fill(course.isOpen ? LongwoodTheme.success : LongwoodTheme.error)
                            .frame(width: 8, height: 8)
                        
                        Text("\(course.availableSeats) seats")
                            .font(.caption)
                            .foregroundColor(course.isOpen ? .primary : .secondary)
                    }
                }
            }
            .padding(.top, 4)
            
            // Time conflict warning if applicable
            if hasTimeConflict && !isRegistered {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(LongwoodTheme.error)
                        .font(.caption)
                    
                    if let conflict = conflictingCourse {
                        Text("Conflicts with \(conflict.courseCode) (\(conflict.meetingTime))")
                            .font(.caption)
                            .foregroundColor(LongwoodTheme.error)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text("This course conflicts with your schedule")
                            .font(.caption)
                            .foregroundColor(LongwoodTheme.error)
                    }
                }
                .padding(.top, 4)
            }
            
            // Prerequisites if any
            if !course.prerequisites.isEmpty {
                Text("Prerequisites: \(course.prerequisites.joined(separator: ", "))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 4)
            }
            
            Spacer(minLength: 16)
            
            // Action button
            Button(action: {
                if isRegistered {
                    showingActionAlert = true
                    alertTitle = "Drop Course"
                    alertMessage = "Are you sure you want to drop \(course.title)?"
                } else if isWaitlisted {
                    showingActionAlert = true
                    alertTitle = "Leave Waitlist"
                    alertMessage = "Are you sure you want to leave the waitlist for \(course.title)?"
                } else if hasTimeConflict {
                    showingActionAlert = true
                    alertTitle = "Schedule Conflict"
                    if let conflict = conflictingCourse {
                        alertMessage = "This course conflicts with \(conflict.courseCode): \(conflict.meetingTime). What would you like to do?"
                    } else {
                        alertMessage = "This course conflicts with your current schedule. What would you like to do?"
                    }
                } else {
                    if isRegistered {
                        // This is a safety check in case the button is clicked for an already registered course
                        showingActionAlert = true
                        alertTitle = "Already Registered"
                        alertMessage = "You are already registered for \(course.title). You cannot register for the same course twice."
                    } else if course.availableSeats > 0 {
                        // This will be prevented in the ViewModel if already registered
                        onRegister()
                        successMessage = "You're now registered for \(course.title)."
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
            .disabled((course.availableSeats == 0 && !isRegistered && !isWaitlisted) || (hasTimeConflict && !isRegistered && !isWaitlisted && onReplace == nil))
            .alert(isPresented: $showingActionAlert) {
                if hasTimeConflict && !isRegistered && !isWaitlisted && conflictingCourse != nil {
                    return Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        primaryButton: .default(Text("View Schedule")) {
                            // Navigate to schedule view
                            if let viewSchedule = onViewSchedule {
                                viewSchedule()
                            }
                        },
                        secondaryButton: .destructive(Text("Replace \(conflictingCourse?.courseCode ?? "")")) {
                            if let conflict = conflictingCourse, let replace = onReplace {
                                replace(conflict)
                                successMessage = "Replaced \(conflict.courseCode) with \(course.courseCode)."
                                showingSuccessAlert = true
                            }
                        }
                    )
                } else if isRegistered || isWaitlisted {
                    return Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        primaryButton: .destructive(Text(isRegistered ? "Drop" : "Leave Waitlist")) {
                            onDrop()
                            successMessage = isRegistered 
                                ? "You've successfully dropped \(course.title)."
                                : "You've been removed from the waitlist for \(course.title)."
                            showingSuccessAlert = true
                        },
                        secondaryButton: .cancel()
                    )
                } else {
                    return Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        primaryButton: .default(Text("Join Waitlist")) {
                            onWaitlist()
                            successMessage = "You've been added to the waitlist for \(course.title)."
                            showingSuccessAlert = true
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .alert("Success", isPresented: $showingSuccessAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(successMessage)
            }
        }
        .padding(LongwoodTheme.defaultPadding)
        .background(
            RoundedRectangle(cornerRadius: LongwoodTheme.cardCornerRadius)
                .fill(LongwoodTheme.cardBackground)
                .shadow(color: LongwoodTheme.cardShadow, radius: LongwoodTheme.cardShadowRadius, x: 0, y: 2)
        )
        .overlay(
            isRegistered ?
                RoundedRectangle(cornerRadius: LongwoodTheme.cardCornerRadius)
                    .strokeBorder(LongwoodTheme.success, lineWidth: 2)
                : isWaitlisted ?
                    RoundedRectangle(cornerRadius: LongwoodTheme.cardCornerRadius)
                        .strokeBorder(LongwoodTheme.warning, lineWidth: 2)
                : hasTimeConflict ?
                    RoundedRectangle(cornerRadius: LongwoodTheme.cardCornerRadius)
                        .strokeBorder(LongwoodTheme.error, lineWidth: 2)
                : nil
        )
    }
    
    private var buttonColor: Color {
        if isRegistered {
            return LongwoodTheme.error
        } else if isWaitlisted {
            return LongwoodTheme.error
        } else if hasTimeConflict {
            return LongwoodTheme.error
        } else if course.availableSeats == 0 {
            return LongwoodTheme.warning
        } else {
            return LongwoodTheme.primaryBlue
        }
    }
    
    private var buttonText: String {
        if isRegistered {
            return "Drop Course"
        } else if isWaitlisted {
            return "Leave Waitlist"
        } else if hasTimeConflict {
            return "Schedule Conflict"
        } else if course.availableSeats == 0 {
            return "Join Waitlist"
        } else {
            return "Register"
        }
    }
    
    private var buttonIcon: String {
        if isRegistered || isWaitlisted {
            return "minus.circle"
        } else if hasTimeConflict {
            return "exclamationmark.triangle"
        } else {
            return "plus.circle"
        }
    }
}

// Helper view for info rows
struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(LongwoodTheme.subtleText)
                .frame(width: 16)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    let sampleViewModel = RegistrationViewModel()
    let sampleCourse = sampleViewModel.courses.first!
    return CourseCardView(
        course: sampleCourse,
        isRegistered: false,
        isWaitlisted: false,
        onRegister: {},
        onDrop: {},
        onWaitlist: {},
        hasTimeConflict: false
    )
} 