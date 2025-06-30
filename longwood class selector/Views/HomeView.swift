import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @EnvironmentObject private var tabController: TabController
    @State private var showingCourseDetail = false
    @State private var selectedCourse: Course?
    @State private var searchText = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isSuccessToast = true
    @State private var selectedCourseLevel: CourseLevel? = nil
    @State private var showingSchedule = false
    
    var body: some View {
        mainContentView
            .navigationTitle("Course Catalog")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    sortingMenu
                }
            }
            .onAppear {
                LongwoodTheme.applyTheme()
            }
    }
    
    private var mainContentView: some View {
        ZStack {
            VStack(spacing: 0) {
                // Search header
                searchHeader
                
                // Courses list
                coursesList
            }
            
            // Toast notification
            toastOverlay
        }
        .sheet(isPresented: $showingCourseDetail, onDismiss: {
            selectedCourse = nil
        }) {
            if let course = selectedCourse {
                CourseDetailView(
                    course: course,
                    isRegistered: viewModel.isRegistered(for: course),
                    isWaitlisted: viewModel.isWaitlisted(for: course),
                    onRegister: {
                        if viewModel.isRegistered(for: course) {
                            showAlreadyRegisteredToast(course: course)
                        } else if let conflictingCourse = viewModel.hasScheduleConflict(course) {
                            showScheduleConflictToast(course: course, conflictingCourse: conflictingCourse)
                        } else {
                            viewModel.registerForCourse(course)
                            showRegistrationToast(course: course)
                        }
                    },
                    onDrop: {
                        if viewModel.isRegistered(for: course) {
                            viewModel.dropCourse(course)
                            showDropToast(course: course)
                        } else if viewModel.isWaitlisted(for: course) {
                            viewModel.removeFromWaitlist(course)
                            showWaitlistRemovedToast(course: course)
                        }
                    },
                    onWaitlist: {
                        viewModel.joinWaitlist(for: course)
                        showWaitlistToast(course: course)
                    },
                    conflictingCourse: viewModel.hasScheduleConflict(course),
                    onReplace: { conflictingCourse in
                        viewModel.replaceAndRegister(dropCourse: conflictingCourse, registerCourse: course)
                        showReplaceToast(droppedCourse: conflictingCourse, newCourse: course)
                        showingCourseDetail = false
                    },
                    onViewSchedule: {
                        showingCourseDetail = false
                        tabController.switchToSchedule()
                    }
                )
                .environmentObject(tabController)
            }
        }
    }
    
    private var coursesList: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Department filters
                departmentFilters
                
                if viewModel.isLoading {
                    loadingView
                } else if filteredCourses.isEmpty {
                    emptySearchResultsView
                } else {
                    courseCardsList
                }
            }
        }
        .refreshable {
            viewModel.refreshCourses()
        }
    }
    
    private var departmentFilters: some View {
        Group {
            if !filteredDepartments.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(filteredDepartments, id: \.self) { department in
                            DepartmentFilterButton(
                                department: department,
                                isSelected: viewModel.selectedDepartment == department,
                                action: {
                                    viewModel.selectedDepartment = department == viewModel.selectedDepartment ? nil : department
                                }
                            )
                        }
                    }
                    .padding(.horizontal, LongwoodTheme.defaultPadding)
                    .padding(.vertical, 8)
                }
                .background(LongwoodTheme.lightGray)
            }
        }
    }
    
    private var emptySearchResultsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 50))
                .foregroundColor(LongwoodTheme.subtleText)
            
            Text("No courses match your search")
                .font(.headline)
                .foregroundColor(LongwoodTheme.subtleText)
            
            Text("Try adjusting your search terms or filters")
                .font(.subheadline)
                .foregroundColor(LongwoodTheme.subtleText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
    
    private var courseCardsList: some View {
        LazyVStack(spacing: 12) {
            ForEach(filteredCourses) { course in
                CourseCardView(
                    course: course,
                    isRegistered: viewModel.isRegistered(for: course),
                    isWaitlisted: viewModel.isWaitlisted(for: course),
                    onRegister: {
                        if viewModel.isRegistered(for: course) {
                            showAlreadyRegisteredToast(course: course)
                        } else if let conflictingCourse = viewModel.hasScheduleConflict(course) {
                            showScheduleConflictToast(course: course, conflictingCourse: conflictingCourse)
                        } else {
                            viewModel.registerForCourse(course)
                            showRegistrationToast(course: course)
                        }
                    },
                    onDrop: {
                        if viewModel.isRegistered(for: course) {
                            viewModel.dropCourse(course)
                            showDropToast(course: course)
                        } else if viewModel.isWaitlisted(for: course) {
                            viewModel.removeFromWaitlist(course)
                            showWaitlistRemovedToast(course: course)
                        }
                    },
                    onWaitlist: {
                        viewModel.joinWaitlist(for: course)
                        showWaitlistToast(course: course)
                    },
                    hasTimeConflict: viewModel.hasScheduleConflict(course) != nil,
                    conflictingCourse: viewModel.hasScheduleConflict(course),
                    onReplace: { conflictingCourse in
                        viewModel.replaceAndRegister(dropCourse: conflictingCourse, registerCourse: course)
                        showReplaceToast(droppedCourse: conflictingCourse, newCourse: course)
                    },
                    onViewSchedule: {
                        tabController.switchToSchedule()
                    }
                )
                .onTapGesture {
                    selectedCourse = course
                    showingCourseDetail = true
                }
            }
        }
        .padding(.horizontal, LongwoodTheme.defaultPadding)
        .padding(.bottom, LongwoodTheme.defaultPadding)
    }
    
    private var toastOverlay: some View {
        Group {
            if showToast {
                VStack {
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Image(systemName: isSuccessToast ? "checkmark.circle.fill" : "info.circle.fill")
                            .foregroundColor(.white)
                        
                        Text(toastMessage)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showToast = false
                            }
                        }) {
                            Image(systemName: "xmark")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isSuccessToast ? LongwoodTheme.success : LongwoodTheme.primaryBlue)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, LongwoodTheme.defaultPadding)
                    .padding(.bottom, 8)
                }
                .transition(.move(edge: .bottom))
                .animation(.spring(), value: showToast)
                .zIndex(100)
            }
        }
    }
    
    private var sortingMenu: some View {
        Menu {
            Button(action: {
                viewModel.sortCriteria = .alphabetical
            }) {
                Label("Alphabetical", systemImage: "textformat")
            }
            
            Button(action: {
                viewModel.sortCriteria = .department
            }) {
                Label("Department", systemImage: "building.2")
            }
            
            Button(action: {
                viewModel.sortCriteria = .credits
            }) {
                Label("Credits", systemImage: "number")
            }
            
            Button(action: {
                viewModel.sortCriteria = .availability
            }) {
                Label("Availability", systemImage: "person.crop.circle.badge.checkmark")
            }
            
            Button(action: {
                viewModel.sortCriteria = .courseLevel
            }) {
                Label("Course Level", systemImage: "arrow.up.right.square")
            }
            
            Button(action: {
                viewModel.sortCriteria = .meetingTime
            }) {
                Label("Meeting Time", systemImage: "clock")
            }
        } label: {
            Label("Sort", systemImage: "arrow.up.arrow.down")
                .foregroundColor(LongwoodTheme.primaryBlue)
        }
    }
    
    // Helper functions for toast notifications
    private func showRegistrationToast(course: Course) {
        isSuccessToast = true
        toastMessage = "Registered for \(course.courseCode)"
        showToastMessage()
    }
    
    private func showDropToast(course: Course) {
        isSuccessToast = true
        toastMessage = "Dropped \(course.courseCode)"
        showToastMessage()
    }
    
    private func showAlreadyRegisteredToast(course: Course) {
        isSuccessToast = false
        toastMessage = "You are already registered for \(course.courseCode)"
        showToastMessage()
    }
    
    private func showScheduleConflictToast(course: Course, conflictingCourse: Course) {
        isSuccessToast = false
        toastMessage = "Schedule conflict between \(course.courseCode) and \(conflictingCourse.courseCode)"
        showToastMessage()
    }
    
    private func showWaitlistToast(course: Course) {
        isSuccessToast = false
        toastMessage = "Added to waitlist for \(course.courseCode) - \(course.title)"
        showToastMessage()
    }
    
    private func showWaitlistRemovedToast(course: Course) {
        isSuccessToast = true
        toastMessage = "Removed from waitlist for \(course.courseCode) - \(course.title)"
        showToastMessage()
    }
    
    private func showReplaceToast(droppedCourse: Course, newCourse: Course) {
        isSuccessToast = true
        toastMessage = "Replaced \(droppedCourse.courseCode) with \(newCourse.courseCode)"
        showToastMessage()
    }
    
    private func showToastMessage() {
        withAnimation {
            showToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                showToast = false
            }
        }
    }
    
    private var searchHeader: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(LongwoodTheme.subtleText)
                
                TextField("Search courses...", text: $searchText)
                    .font(.body)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(LongwoodTheme.subtleText)
                    }
                }
            }
            .padding(LongwoodTheme.smallPadding)
            .background(LongwoodTheme.lightGray)
            .cornerRadius(LongwoodTheme.cornerRadius)
            .padding(.horizontal, LongwoodTheme.defaultPadding)
            .padding(.vertical, LongwoodTheme.smallPadding)
            
            // Filter chips
            filterControls
        }
        .background(Color.white)
        .shadow(color: LongwoodTheme.mediumGray.opacity(0.1), radius: 2, x: 0, y: 2)
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .padding(.bottom, 10)
            
            Text("Loading courses...")
                .font(.headline)
                .foregroundColor(LongwoodTheme.subtleText)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
        .padding(.bottom, 60)
    }
    
    private var filterControls: some View {
        VStack(spacing: 8) {
            // Existing filter chips
            HStack {
                Text("Filters: ")
                    .font(.subheadline)
                    .foregroundColor(LongwoodTheme.subtleText)
                
                // Open courses filter
                FilterChip(
                    text: "Open Courses",
                    isSelected: viewModel.showOpenCoursesOnly,
                    action: { viewModel.showOpenCoursesOnly.toggle() }
                )
                
                Spacer()
                
                Button(action: {
                    viewModel.resetFilters()
                    selectedCourseLevel = nil
                }) {
                    Text("Reset")
                        .font(.caption)
                        .foregroundColor(LongwoodTheme.primaryBlue)
                }
            }
            
            // Course level filters
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    FilterChip(
                        text: "All Levels",
                        isSelected: selectedCourseLevel == nil,
                        action: { selectedCourseLevel = nil }
                    )
                    
                    FilterChip(
                        text: "Freshman (100)",
                        isSelected: selectedCourseLevel == .freshman,
                        action: { selectedCourseLevel = .freshman }
                    )
                    
                    FilterChip(
                        text: "Sophomore (200)",
                        isSelected: selectedCourseLevel == .sophomore,
                        action: { selectedCourseLevel = .sophomore }
                    )
                    
                    FilterChip(
                        text: "Junior (300)",
                        isSelected: selectedCourseLevel == .junior,
                        action: { selectedCourseLevel = .junior }
                    )
                    
                    FilterChip(
                        text: "Senior (400)",
                        isSelected: selectedCourseLevel == .senior,
                        action: { selectedCourseLevel = .senior }
                    )
                    
                    FilterChip(
                        text: "Graduate (500+)",
                        isSelected: selectedCourseLevel == .graduate,
                        action: { selectedCourseLevel = .graduate }
                    )
                }
                .padding(.horizontal)
            }
        }
        .padding(.horizontal, LongwoodTheme.defaultPadding)
        .padding(.vertical, 8)
        .background(LongwoodTheme.lightGray.opacity(0.5))
    }
    
    var filteredCourses: [Course] {
        var results = viewModel.courses
        
        // Apply search text filter
        if !searchText.isEmpty {
            results = results.filter { course in
                let titleMatch = course.title.lowercased().contains(searchText.lowercased())
                let codeMatch = course.courseCode.lowercased().contains(searchText.lowercased())
                let instructorMatch = course.instructor.lowercased().contains(searchText.lowercased())
                let departmentMatch = course.department.lowercased().contains(searchText.lowercased())
                
                return titleMatch || codeMatch || instructorMatch || departmentMatch
            }
        }
        
        // Apply department filter
        if let department = viewModel.selectedDepartment {
            results = results.filter { $0.department == department }
        }
        
        // Apply course level filter
        if let level = selectedCourseLevel {
            results = results.filter { $0.courseLevel == level }
        }
        
        // Apply open courses filter
        if viewModel.showOpenCoursesOnly {
            results = results.filter { $0.isOpen }
        }
        
        // Apply sorting
        switch viewModel.sortCriteria {
        case .alphabetical:
            results.sort { $0.title < $1.title }
        case .department:
            results.sort { $0.department < $1.department }
        case .credits:
            results.sort { $0.credits > $1.credits }
        case .availability:
            results.sort { $0.availableSeats > $1.availableSeats }
        case .courseLevel:
            results.sort { $0.courseLevel.rawValue < $1.courseLevel.rawValue }
        case .meetingTime:
            results.sort { $0.meetingTime < $1.meetingTime }
        }
        
        return results
    }
    
    var filteredDepartments: [String] {
        let departments = Set(viewModel.courses.map { $0.department })
        return Array(departments).sorted()
    }
    
    private var totalCredits: Int {
        viewModel.registeredCourses.reduce(0) { $0 + $1.credits }
    }
    
    private var creditInfoHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Course Catalog")
                    .font(.headline)
                
                Text("\(viewModel.registeredCourses.count) courses enrolled • \(totalCredits) credits")
                    .font(.subheadline)
                    .foregroundColor(LongwoodTheme.subtleText)
            }
            
            Spacer()
            
            navigateToScheduleButton
        }
        .padding(.horizontal, LongwoodTheme.defaultPadding)
        .padding(.top, LongwoodTheme.smallPadding)
        .padding(.bottom, LongwoodTheme.smallPadding)
        .background(Color.white)
    }
    
    private var navigateToScheduleButton: some View {
        NavigationLink(destination: ScheduleView(viewModel: viewModel)) {
            HStack(spacing: 4) {
                Text("View Schedule")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Image(systemName: "chevron.right")
                    .font(.caption)
            }
            .foregroundColor(LongwoodTheme.primaryBlue)
        }
    }
}

struct DepartmentFilterButton: View {
    let department: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(department)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(isSelected ? LongwoodTheme.colorForDepartment(department) : Color.white)
                )
                .foregroundColor(isSelected ? .white : LongwoodTheme.darkGray)
                .shadow(color: LongwoodTheme.mediumGray.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

struct FilterChip: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.caption)
                
                Text(text)
                    .font(.caption)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(isSelected ? LongwoodTheme.primaryBlue.opacity(0.1) : Color.white)
                    .strokeBorder(isSelected ? LongwoodTheme.primaryBlue : LongwoodTheme.mediumGray, lineWidth: 1)
            )
            .foregroundColor(isSelected ? LongwoodTheme.primaryBlue : LongwoodTheme.darkGray)
        }
    }
}

#Preview {
    HomeView(viewModel: RegistrationViewModel())
        .environmentObject(TabController())
} 