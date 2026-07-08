import SwiftUI

/// Displays application settings and preferences.
struct SettingsView: View {
    // MARK: - Environment Objects
    
    @EnvironmentObject var viewModel: DashboardViewModel
    
    // MARK: - State Properties
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: Constants.Spacing.large) {
            // Header
            HStack {
                Text("Settings")
                    .font(.system(size: Constants.FontSize.headline, weight: .semibold))
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(Constants.Spacing.large)
            
            // Settings content
            Form {
                Section(header: Text("Application")) {
                    Picker("Selected Agent", selection: $viewModel.selectedAgent) {
                        ForEach(EstateAgent.allAgents, id: \.self) { agent in
                            Text(agent.name)
                                .tag(agent)
                        }
                    }
                }
                
                Section(header: Text("Data")) {
                    Button(role: .destructive) {
                        viewModel.clearProperties()
                        dismiss()
                    } label: {
                        Text("Clear All Data")
                    }
                    .disabled(viewModel.properties.isEmpty)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Application")
                        Spacer()
                        Text("Blinc MTI Manager")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Company")
                        Spacer()
                        Text("Blinc Property Reports")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Email")
                        Spacer()
                        Link(Constants.Email.supportEmail, destination: URL(string: "mailto:\(Constants.Email.supportEmail)")!)
                            .foregroundColor(Constants.brandColor)
                    }
                }
            }
            .padding(Constants.Spacing.large)
            
            Spacer()
        }
        .frame(width: 500)
    }
}

#Preview {
    let viewModel = DashboardViewModel()
    
    return SettingsView()
        .environmentObject(viewModel)
}
