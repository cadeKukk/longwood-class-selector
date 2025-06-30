import SwiftUI

struct LongwoodTheme {
    // Longwood University's official colors
    static let primaryBlue = Color(red: 0/255, green: 58/255, blue: 112/255) // Longwood Blue
    static let secondaryGreen = Color(red: 123/255, green: 175/255, blue: 122/255) // Longwood Gray-Green
    
    // Enhanced UI colors
    static let lightGray = Color(red: 245/255, green: 245/255, blue: 247/255)
    static let mediumGray = Color(red: 229/255, green: 229/255, blue: 234/255)
    static let darkGray = Color(red: 80/255, green: 80/255, blue: 80/255)
    static let subtleText = Color(red: 120/255, green: 120/255, blue: 128/255)
    
    // Status colors
    static let success = Color(red: 52/255, green: 199/255, blue: 89/255)
    static let warning = Color(red: 255/255, green: 149/255, blue: 0/255)
    static let error = Color(red: 255/255, green: 59/255, blue: 48/255)
    
    // UI constants
    static let cornerRadius = 10.0
    static let cardCornerRadius = 12.0
    static let defaultPadding = 16.0
    static let smallPadding = 8.0
    static let buttonHeight = 48.0
    static let cardShadow = Color.black.opacity(0.1)
    static let cardShadowRadius = 4.0
    
    // Card appearance
    static let cardBackground = Color(.systemBackground)
    static let selectedCardBackground = Color(.systemBackground).opacity(0.9)
    
    // Apply theme to the app UI elements
    static func applyTheme() {
        // Set navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(primaryBlue)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .white
        
        // Set tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.systemBackground
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = UIColor(primaryBlue)
    }
    
    // Course color by department
    static func colorForDepartment(_ department: String) -> Color {
        switch department {
        case "Accounting":
            return Color(red: 0.2, green: 0.6, blue: 0.8) // Light blue
        case "Anthropology":
            return Color(red: 0.8, green: 0.4, blue: 0.2) // Rust orange
        case "Art":
            return Color(red: 0.9, green: 0.2, blue: 0.3) // Coral red
        case "Biology":
            return Color(red: 0.2, green: 0.7, blue: 0.3) // Forest green
        case "Business":
            return Color(red: 0.3, green: 0.4, blue: 0.8) // Royal blue
        case "Chemistry":
            return Color(red: 0.6, green: 0.2, blue: 0.8) // Purple
        case "Communication Studies":
            return Color(red: 0.8, green: 0.6, blue: 0.2) // Gold
        case "Computer Science":
            return Color(red: 0.2, green: 0.3, blue: 0.6) // Navy blue
        case "Economics":
            return Color(red: 0.4, green: 0.2, blue: 0.6) // Indigo
        case "Education":
            return Color(red: 0.9, green: 0.5, blue: 0.1) // Orange
        case "English":
            return Color(red: 0.7, green: 0.2, blue: 0.5) // Magenta
        case "History":
            return Color(red: 0.5, green: 0.3, blue: 0.2) // Brown
        case "Mathematics":
            return Color(red: 0.2, green: 0.5, blue: 0.7) // Teal
        case "Music":
            return Color(red: 0.8, green: 0.2, blue: 0.7) // Pink
        case "Nursing":
            return Color(red: 0.7, green: 0.2, blue: 0.3) // Rose red
        case "Philosophy":
            return Color(red: 0.3, green: 0.6, blue: 0.4) // Sage green
        case "Physics":
            return Color(red: 0.4, green: 0.2, blue: 0.8) // Deep purple
        case "Political Science":
            return Color(red: 0.8, green: 0.3, blue: 0.4) // Crimson
        case "Psychology":
            return Color(red: 0.6, green: 0.4, blue: 0.2) // Bronze
        case "Sociology":
            return Color(red: 0.5, green: 0.5, blue: 0.2) // Olive
        case "Theatre":
            return Color(red: 0.7, green: 0.4, blue: 0.6) // Lavender
        default:
            return primaryBlue
        }
    }
} 