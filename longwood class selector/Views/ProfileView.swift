import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @State private var isEditing = false
    @State private var showingSuccessAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: LongwoodTheme.defaultPadding) {
                // Profile header
                VStack(spacing: LongwoodTheme.smallPadding) {
                    Image("longwood_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(LongwoodTheme.primaryBlue, lineWidth: 3))
                        .shadow(color: LongwoodTheme.mediumGray.opacity(0.2), radius: 5)
                        .padding(.bottom, 4)
                    
                    Text(viewModel.currentStudent.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(viewModel.currentStudent.major)
                        .font(.headline)
                        .foregroundColor(LongwoodTheme.subtleText)
                    
                    Text(viewModel.currentStudent.classYear)
                        .font(.subheadline)
                        .foregroundColor(LongwoodTheme.subtleText)
                        .padding(.top, 2)
                }
                .padding(.vertical, LongwoodTheme.defaultPadding)
                
                // Edit/Save button
                HStack {
                    Spacer()
                    Button(action: {
                        if isEditing {
                            showingSuccessAlert = true
                        }
                        isEditing.toggle()
                    }) {
                        HStack {
                            Image(systemName: isEditing ? "checkmark" : "pencil")
                            Text(isEditing ? "Save Changes" : "Edit Profile")
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(isEditing ? LongwoodTheme.success : LongwoodTheme.primaryBlue)
                        )
                    }
                }
                .padding(.horizontal, LongwoodTheme.defaultPadding)
                
                // Personal Information Section
                VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
                    Text("Personal Information")
                        .font(.headline)
                        .padding(.horizontal, LongwoodTheme.defaultPadding)
                    
                    VStack(spacing: 0) {
                        EditableInfoRow(
                            title: "Full Name",
                            value: $viewModel.currentStudent.name,
                            isEditing: isEditing
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        EditableInfoRow(
                            title: "Student ID",
                            value: $viewModel.currentStudent.studentID,
                            isEditing: isEditing
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        EditableInfoRow(
                            title: "Longwood Email",
                            value: $viewModel.currentStudent.email,
                            isEditing: isEditing,
                            keyboardType: .emailAddress
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        EditableInfoRow(
                            title: "Phone Number",
                            value: $viewModel.currentStudent.phoneNumber,
                            isEditing: isEditing,
                            keyboardType: .phonePad,
                            placeholder: "(Optional)"
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        EditableInfoRow(
                            title: "Address",
                            value: $viewModel.currentStudent.address,
                            isEditing: isEditing,
                            placeholder: "(Optional)"
                        )
                    }
                    .padding(LongwoodTheme.defaultPadding)
                    .background(
                        RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                            .fill(Color.white)
                            .shadow(color: LongwoodTheme.mediumGray.opacity(0.1), radius: 3, x: 0, y: 2)
                    )
                    .padding(.horizontal, LongwoodTheme.defaultPadding)
                }
                
                // Academic Information Section
                VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
                    Text("Academic Information")
                        .font(.headline)
                        .padding(.horizontal, LongwoodTheme.defaultPadding)
                    
                    VStack(spacing: 0) {
                        EditableInfoRow(
                            title: "Major",
                            value: $viewModel.currentStudent.major,
                            isEditing: isEditing
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        EditableInfoRow(
                            title: "Class Year",
                            value: $viewModel.currentStudent.classYear,
                            isEditing: isEditing
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        EditableInfoRow(
                            title: "Academic Advisor",
                            value: $viewModel.currentStudent.advisor,
                            isEditing: isEditing
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        StudentInfoRow(title: "Total Credits", value: "\(viewModel.registeredCourses.reduce(0) { $0 + $1.credits })")
                    }
                    .padding(LongwoodTheme.defaultPadding)
                    .background(
                        RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                            .fill(Color.white)
                            .shadow(color: LongwoodTheme.mediumGray.opacity(0.1), radius: 3, x: 0, y: 2)
                    )
                    .padding(.horizontal, LongwoodTheme.defaultPadding)
                }
                
                // Emergency Contact Section
                VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
                    Text("Emergency Contact")
                        .font(.headline)
                        .padding(.horizontal, LongwoodTheme.defaultPadding)
                    
                    VStack(spacing: 0) {
                        EditableInfoRow(
                            title: "Contact Name",
                            value: $viewModel.currentStudent.emergencyContact,
                            isEditing: isEditing,
                            placeholder: "(Optional)"
                        )
                        
                        Divider().padding(.vertical, 8)
                        
                        EditableInfoRow(
                            title: "Contact Phone",
                            value: $viewModel.currentStudent.emergencyPhone,
                            isEditing: isEditing,
                            keyboardType: .phonePad,
                            placeholder: "(Optional)"
                        )
                    }
                    .padding(LongwoodTheme.defaultPadding)
                    .background(
                        RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                            .fill(Color.white)
                            .shadow(color: LongwoodTheme.mediumGray.opacity(0.1), radius: 3, x: 0, y: 2)
                    )
                    .padding(.horizontal, LongwoodTheme.defaultPadding)
                }
                
                // Registration status
                VStack(alignment: .leading, spacing: LongwoodTheme.smallPadding) {
                    Text("Registration Status")
                        .font(.headline)
                        .padding(.horizontal, LongwoodTheme.defaultPadding)
                    
                    VStack(spacing: 0) {
                        StatusRow(
                            title: "Registration Period",
                            value: viewModel.currentStudent.isRegistrationOpen ? "Open" : "Closed",
                            isPositive: viewModel.currentStudent.isRegistrationOpen
                        )
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        StatusRow(
                            title: "Financial Hold",
                            value: viewModel.currentStudent.hasFinancialHold ? "Active" : "None",
                            isPositive: !viewModel.currentStudent.hasFinancialHold
                        )
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        StatusRow(
                            title: "Advising Hold",
                            value: viewModel.currentStudent.hasAdvisingHold ? "Active" : "None",
                            isPositive: !viewModel.currentStudent.hasAdvisingHold
                        )
                    }
                    .padding(LongwoodTheme.defaultPadding)
                    .background(
                        RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                            .fill(Color.white)
                            .shadow(color: LongwoodTheme.mediumGray.opacity(0.1), radius: 3, x: 0, y: 2)
                    )
                    .padding(.horizontal, LongwoodTheme.defaultPadding)
                }
                
                // Action buttons
                VStack(spacing: LongwoodTheme.smallPadding) {
                    ActionButton(
                        icon: "doc.text",
                        title: "View Degree Audit",
                        description: "Track your progress toward graduation",
                        action: {}
                    )
                    
                    ActionButton(
                        icon: "calendar",
                        title: "Registration Time Slot",
                        description: "Your registration opens \(viewModel.currentStudent.timeSlot)",
                        action: {}
                    )
                    
                    ActionButton(
                        icon: "person.badge.clock",
                        title: "Advising Appointment",
                        description: "Schedule a meeting with your advisor",
                        action: {}
                    )
                }
                .padding(.horizontal, LongwoodTheme.defaultPadding)
                
                // Log out button
                Button(action: {
                    // Log out action
                }) {
                    HStack {
                        Spacer()
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(LongwoodTheme.error)
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                            .strokeBorder(LongwoodTheme.error, lineWidth: 2)
                    )
                    .padding(.horizontal, LongwoodTheme.defaultPadding)
                    .padding(.top, LongwoodTheme.smallPadding)
                }
            }
            .padding(.bottom, LongwoodTheme.defaultPadding * 2)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Profile Updated", isPresented: $showingSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your profile information has been saved successfully.")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Settings action
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(LongwoodTheme.primaryBlue)
                }
            }
        }
    }
}

struct EditableInfoRow: View {
    let title: String
    @Binding var value: String
    let isEditing: Bool
    var keyboardType: UIKeyboardType = .default
    var placeholder: String = ""
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(LongwoodTheme.subtleText)
                .frame(width: 120, alignment: .leading)
            
            if isEditing {
                TextField(placeholder.isEmpty ? title : placeholder, text: $value)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .keyboardType(keyboardType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Spacer()
                Text(value.isEmpty ? placeholder : value)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(value.isEmpty ? LongwoodTheme.subtleText.opacity(0.6) : .primary)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct StudentInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(LongwoodTheme.subtleText)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

struct StatusRow: View {
    let title: String
    let value: String
    let isPositive: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(LongwoodTheme.subtleText)
            
            Spacer()
            
            HStack(spacing: 6) {
                Circle()
                    .fill(isPositive ? LongwoodTheme.success : LongwoodTheme.error)
                    .frame(width: 8, height: 8)
                
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(isPositive ? LongwoodTheme.success : LongwoodTheme.error)
            }
        }
    }
}

struct ActionButton: View {
    let icon: String
    let title: String
    let description: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: LongwoodTheme.defaultPadding) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(LongwoodTheme.primaryBlue)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(LongwoodTheme.subtleText)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(LongwoodTheme.subtleText)
            }
            .padding(LongwoodTheme.defaultPadding)
            .background(
                RoundedRectangle(cornerRadius: LongwoodTheme.cornerRadius)
                    .fill(Color.white)
                    .shadow(color: LongwoodTheme.mediumGray.opacity(0.1), radius: 3, x: 0, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

