import SwiftUI

struct CourseListView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @EnvironmentObject private var tabController: TabController
    @State private var selectedCourse: Course?
    @State private var isShowingDetail = false
    @State private var searchText: String = ""
    
    // Grid layout
    private let columns = [
        GridItem(.adaptive(minimum: 300, maximum: 400), spacing: 16)
    ]
    
    var body: some View {
        mainContent
            .navigationTitle("Course Catalog")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ScheduleView(viewModel: viewModel)) {
                        HStack {
                            Text("Schedule")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Image(systemName: "calendar")
                        }
                        .foregroundColor(LongwoodTheme.primaryBlue)
                    }
                }
            }
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            // Search and Filter Bar
            searchAndFilterBar
            
            // Course Grid
            courseGridView
        }
    }
    
    private var searchAndFilterBar: some View {
        VStack(spacing: 16) {
            searchField
            filterControls
        }
        .padding(.vertical)
        .background(Color.white)
    }
    
    private var searchField: some View {
        TextField("Search courses, instructors, or course codes", text: $searchText)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .overlay(
                HStack {
                    Spacer()
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 24)
                        }
                    } else {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing, 24)
                    }
                }
            )
    }
    
    private var filterControls: some View {
        HStack {
            // Department filter
            departmentFilterMenu
            
            Spacer()
            
            // Open courses only toggle
            Toggle(isOn: $viewModel.showOpenCoursesOnly) {
                Text("Open Courses Only")
                    .font(.subheadline)
            }
            .toggleStyle(SwitchToggleStyle(tint: LongwoodTheme.primaryBlue))
        }
        .padding(.horizontal)
    }
    
    private var departmentFilterMenu: some View {
        Menu {
            Button(action: {
                viewModel.selectedDepartment = nil
            }) {
                Text("All Departments")
            }
            
            Divider()
            
            ForEach(Array(Set(viewModel.courses.map { $0.department })).sorted(), id: \.self) { department in
                Button(action: {
                    viewModel.selectedDepartment = department
                }) {
                    if department == viewModel.selectedDepartment {
                        Label(department, systemImage: "checkmark")
                    } else {
                        Text(department)
                    }
                }
            }
        } label: {
            HStack {
                Text(viewModel.selectedDepartment ?? "All Departments")
                    .font(.subheadline)
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
            .padding(8)
            .background(LongwoodTheme.lightGray)
            .cornerRadius(8)
        }
    }
    
    private var courseGridView: some View {
        ScrollView {
            if viewModel.isLoading {
                loadingView
            } else if filteredCourses.isEmpty {
                emptyResultsView
            } else {
                coursesGrid
            }
        }
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
    
    private var emptyResultsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(LongwoodTheme.subtleText)
                .padding(.top, 60)
            
            Text("No courses match your search")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Try adjusting your filters or search terms")
                .font(.subheadline)
                .foregroundColor(LongwoodTheme.subtleText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var coursesGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(filteredCourses) { course in
                CourseCardView(
                    course: course,
                    isRegistered: viewModel.isRegistered(for: course),
                    isWaitlisted: viewModel.isWaitlisted(for: course),
                    onRegister: {
                        if viewModel.isRegistered(for: course) {
                            print("Already registered for \(course.courseCode) - registration prevented in CourseListView")
                        } else if let conflictingCourse = viewModel.hasScheduleConflict(course) {
                            print("Schedule conflict between \(course.courseCode) and \(conflictingCourse.courseCode)")
                        } else {
                            viewModel.registerForCourse(course)
                            print("Attempted to register for \(course.courseCode) from CourseListView")
                        }
                    },
                    onDrop: {
                        viewModel.dropCourse(course)
                    },
                    onWaitlist: {
                        viewModel.joinWaitlist(for: course)
                        print("Added \(course.courseCode) to waitlist from CourseListView")
                    },
                    hasTimeConflict: viewModel.hasScheduleConflict(course) != nil,
                    conflictingCourse: viewModel.hasScheduleConflict(course),
                    onReplace: { conflictingCourse in
                        viewModel.replaceAndRegister(dropCourse: conflictingCourse, registerCourse: course)
                        print("Replaced \(conflictingCourse.courseCode) with \(course.courseCode) from CourseListView")
                    },
                    onViewSchedule: {
                        tabController.switchToSchedule()
                    }
                )
                .onTapGesture {
                    selectedCourse = course
                    isShowingDetail = true
                }
            }
        }
        .padding()
        .sheet(isPresented: $isShowingDetail, content: {
            if let course = selectedCourse {
                CourseDetailView(
                    course: course,
                    isRegistered: viewModel.isRegistered(for: course),
                    isWaitlisted: viewModel.isWaitlisted(for: course),
                    onRegister: {
                        if viewModel.isRegistered(for: course) {
                            print("Already registered for \(course.courseCode) - registration prevented in CourseDetail sheet")
                        } else if let conflictingCourse = viewModel.hasScheduleConflict(course) {
                            print("Schedule conflict between \(course.courseCode) and \(conflictingCourse.courseCode)")
                        } else {
                            viewModel.registerForCourse(course)
                            print("Attempted to register for \(course.courseCode) from CourseDetail sheet")
                        }
                        isShowingDetail = false
                    },
                    onDrop: {
                        viewModel.dropCourse(course)
                        isShowingDetail = false
                    },
                    onWaitlist: {
                        viewModel.joinWaitlist(for: course)
                        print("Added \(course.courseCode) to waitlist from CourseDetail sheet")
                        isShowingDetail = false
                    },
                    conflictingCourse: viewModel.hasScheduleConflict(course),
                    onReplace: { conflictingCourse in
                        viewModel.replaceAndRegister(dropCourse: conflictingCourse, registerCourse: course)
                        print("Replaced \(conflictingCourse.courseCode) with \(course.courseCode) from CourseDetail sheet")
                        isShowingDetail = false
                    },
                    onViewSchedule: {
                        isShowingDetail = false
                        tabController.switchToSchedule()
                    }
                )
                .environmentObject(tabController)
            }
        })
    }
    
    // Custom filtered courses implementation
    private var filteredCourses: [Course] {
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
        
        // Apply open courses filter
        if viewModel.showOpenCoursesOnly {
            results = results.filter { $0.isOpen }
        }
        
        return results
    }
}

#Preview {
    CourseListView(viewModel: RegistrationViewModel())
        .environmentObject(TabController())
} 