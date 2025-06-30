//
//  ContentView.swift
//  longwood class selector
//
//  Created by Cade Kukk on 4/5/25.
//

import SwiftUI

enum Tab {
    case home, courses, schedule, profile
}

// Add a TabController class to manage tab selection across the app
class TabController: ObservableObject {
    @Published var selectedTab: Tab = .home
    
    func switchToSchedule() {
        selectedTab = .schedule
    }
}

struct ContentView: View {
    @StateObject var tabController = TabController()
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        // Create a fully separate TabView to avoid navigation issues
        TabView(selection: $tabController.selectedTab) {
            // Home Tab
            NavigationView {
                HomeView(viewModel: viewModel)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(Tab.home)
            

            
            // Schedule Tab
            NavigationView {
                ScheduleView(viewModel: viewModel)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Schedule", systemImage: "calendar")
            }
            .tag(Tab.schedule)
            
            // Profile Tab  
            NavigationView {
                ProfileView(viewModel: viewModel)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(Tab.profile)
        }
        .accentColor(LongwoodTheme.primaryBlue)
        .environmentObject(tabController)
        .onAppear {
            // Apply custom tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            
            // Use this appearance when scrolling behind the TabView
            UITabBar.appearance().standardAppearance = appearance
            
            // Use this appearance when scrolled all the way up
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            
            LongwoodTheme.applyTheme()
        }
    }
}

#Preview {
    ContentView(viewModel: RegistrationViewModel())
}