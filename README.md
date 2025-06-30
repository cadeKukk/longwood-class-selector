# Longwood Class Selector

A comprehensive iOS course registration app designed specifically for Longwood University students. Built with SwiftUI, this app provides an intuitive interface for browsing courses, managing registrations, and planning academic schedules.

## 🎓 Features

### Course Management
- **Course Catalog**: Browse through comprehensive course listings with detailed information
- **Advanced Search**: Search by course code, title, instructor, or department
- **Smart Filtering**: Filter courses by department, availability, and course level
- **Multiple Sort Options**: Sort by alphabetical order, department, credits, availability, course level, or meeting time

### Registration System
- **One-Click Registration**: Easy course registration with conflict detection
- **Schedule Conflict Detection**: Automatic detection and warning of time conflicts
- **Waitlist Management**: Join waitlists for full courses
- **Course Replacement**: Replace conflicting courses with new selections
- **Prerequisites Checking**: Display course prerequisites for informed decisions

### Schedule Management
- **Weekly Schedule View**: Visual representation of your class schedule
- **Time Conflict Visualization**: Clear indicators of scheduling conflicts
- **Lab Session Integration**: Support for courses with lab components
- **Schedule Export**: Navigate seamlessly between course browsing and schedule viewing

### User Experience
- **Longwood University Branding**: Official university colors and theming
- **Department Color Coding**: Visual distinction between different academic departments
- **Toast Notifications**: Real-time feedback for all user actions
- **Pull-to-Refresh**: Easy course data refreshing
- **Responsive Design**: Optimized for all iPhone screen sizes

## 🛠 Technical Features

- **SwiftUI Framework**: Modern, declarative UI development
- **MVVM Architecture**: Clean separation of concerns with ObservableObject pattern
- **Lazy Loading**: Efficient rendering of large course lists
- **Custom Theming**: Centralized theme management with LongwoodTheme
- **Tab-Based Navigation**: Intuitive navigation between major app sections
- **State Management**: Comprehensive state management for registration status

## 📱 Screenshots

The app features four main sections:
- **Home**: Course catalog with search and filtering capabilities
- **Schedule**: Visual weekly schedule with registered courses
- **Profile**: Student information and registration summary

## 🔧 Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/longwood-class-selector.git
   cd longwood-class-selector
   ```

2. **Open in Xcode**
   ```bash
   open "longwood class selector.xcodeproj"
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

## 📖 Usage

### Getting Started
1. Launch the app to see the course catalog
2. Use the search bar to find specific courses
3. Apply filters to narrow down your options
4. Tap on any course card to view detailed information

### Course Registration
1. Browse available courses in the Home tab
2. Tap "Register" on desired courses
3. Handle any time conflicts through the conflict resolution dialog
4. View your registered courses in the Schedule tab

### Managing Your Schedule
1. Navigate to the Schedule tab to see your weekly schedule
2. Use the visual schedule to identify time conflicts
3. Drop courses directly from the schedule view
4. Access your profile information in the Profile tab

## 🏗 Project Structure

```
longwood class selector/
├── longwood_class_selectorApp.swift    # App entry point
├── ContentView.swift                   # Main tab view controller
├── Model/
│   ├── Course.swift                    # Course data model
│   ├── Student.swift                   # Student data model
│   ├── CourseViewModel.swift           # Main business logic
│   ├── CourseDataService.swift         # Course data provider
│   ├── LongwoodTheme.swift            # UI theme definitions
│   └── Toast.swift                     # Toast notification system
├── Views/
│   ├── HomeView.swift                  # Course catalog view
│   ├── CourseCardView.swift            # Individual course card
│   ├── CourseDetailView.swift          # Detailed course information
│   ├── CourseListView.swift            # Course list presentation
│   ├── ScheduleView.swift              # Schedule management
│   ├── WeeklyScheduleView.swift        # Weekly schedule visualization
│   ├── ProfileView.swift               # User profile
│   └── MainTabView.swift               # Tab navigation
└── Assets.xcassets/                    # App icons and images
```

## 🎨 Design Philosophy

The app follows Longwood University's official branding guidelines:
- **Primary Blue**: #003A70 (Longwood Blue)
- **Secondary Green**: #7BAF7A (Longwood Gray-Green)
- **Department Colors**: Each academic department has a unique color for easy identification
- **Modern UI**: Clean, card-based design with subtle shadows and rounded corners

## 🔄 Data Management

The app uses a comprehensive data model that includes:
- **Course Information**: Code, title, instructor, location, time, credits
- **Schedule Data**: Meeting days, time conflicts, lab sessions
- **Registration Status**: Enrolled, waitlisted, available seats
- **Academic Details**: Prerequisites, course level, department

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
1. Follow SwiftUI best practices
2. Maintain the existing code style and architecture
3. Add appropriate comments for complex logic
4. Test thoroughly on different device sizes
5. Ensure accessibility compliance

## 📝 License

This project is created for educational purposes as part of coursework at Longwood University.

## 👨‍💻 Author

**Cade Kukk**
- Created: April 5, 2025
- Course Registration System for Longwood University

## 📞 Support

For questions or issues:
1. Open an issue in the GitHub repository
2. Contact the development team
3. Check the documentation for common solutions

---

*This app is designed specifically for Longwood University students and follows the university's academic policies and procedures.* 