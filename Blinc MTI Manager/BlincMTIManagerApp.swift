import SwiftUI

/// The main entry point for the Blinc MTI Manager application.
/// Configures the application window and initializes the root view.
@main
struct BlincMTIManagerApp: App {
    // MARK: - Properties
    
    @StateObject private var dashboardViewModel = DashboardViewModel()
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(dashboardViewModel)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.recommended)
        .defaultSize(
            width: Constants.WindowSize.idealpreferedWidth,
            height: Constants.WindowSize.idealpreferedHeight
        )
    }
}
