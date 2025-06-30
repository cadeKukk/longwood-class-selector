import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("Courses", systemImage: "book")
                }
            
            ScheduleView(viewModel: viewModel)
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
            
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(LongwoodTheme.primaryBlue)
    }
}

#Preview {
    MainTabView()
} 