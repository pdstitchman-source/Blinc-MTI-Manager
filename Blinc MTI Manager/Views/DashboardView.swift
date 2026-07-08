import SwiftUI

/// The main dashboard view for the Blinc MTI Manager application.
/// Displays the primary interface with estate agent selection, spreadsheet import,
/// statistics, property table, and email preview.
struct DashboardView: View {
    // MARK: - Environment Objects
    
    @EnvironmentObject var viewModel: DashboardViewModel
    
    // MARK: - Body
    
    var body: some View {
        NavigationSplitView {
            // MARK: - Sidebar
            VStack(spacing: Constants.Spacing.large) {
                // Header
                headerSection
                
                // Agent Selection
                agentSelectionSection
                
                // Spreadsheet Import
                spreadsheetSection
                
                // Statistics
                statisticsSection
                
                Spacer()
                
                // Bottom Actions
                actionButtonsSection
            }
            .padding(Constants.Spacing.large)
            .frame(minWidth: 300)
            .background(Color(nsColor: .controlBackgroundColor))
        } detail: {
            // MARK: - Main Content Area
            VStack(spacing: Constants.Spacing.medium) {
                // Property Table
                propertyTableSection
                
                Divider()
                
                // Email Preview
                emailPreviewSection
            }
            .padding(Constants.Spacing.large)
        }
        .sheet(isPresented: $viewModel.showSettings) {
            SettingsView()
                .environmentObject(viewModel)
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.small) {
            Text("Blinc MTI Manager")
                .font(.system(size: Constants.FontSize.largeTitle, weight: .bold))
                .foregroundColor(Constants.brandColor)
            
            Text("Email batch sender for Mid-Term Inspections")
                .font(.system(size: Constants.FontSize.small, weight: .regular))
                .foregroundColor(.secondary)
        }
    }
    
    private var agentSelectionSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.small) {
            Text("Estate Agent")
                .font(.system(size: Constants.FontSize.body, weight: .semibold))
                .foregroundColor(.primary)
            
            Picker("Agent", selection: $viewModel.selectedAgent) {
                ForEach(EstateAgent.allAgents, id: \.self) { agent in
                    Text(agent.name)
                        .tag(agent)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var spreadsheetSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.small) {
            Text("Spreadsheet")
                .font(.system(size: Constants.FontSize.body, weight: .semibold))
                .foregroundColor(.primary)
            
            Button(action: viewModel.selectSpreadsheetFile) {
                HStack(spacing: Constants.Spacing.small) {
                    Image(systemName: "doc.badge.plus")
                    Text("Import MTI Spreadsheet")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .disabled(viewModel.isImporting)
            
            if !viewModel.importedFileName.isEmpty {
                HStack(spacing: Constants.Spacing.small) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    VStack(alignment: .leading, spacing: Constants.Spacing.extraSmall) {
                        Text("File Loaded")
                            .font(.system(size: Constants.FontSize.small, weight: .semibold))
                        
                        Text(viewModel.importedFileName)
                            .font(.system(size: Constants.FontSize.small, weight: .regular))
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                }
                .padding(Constants.Spacing.small)
                .background(Color.green.opacity(0.1))
                .cornerRadius(Constants.CornerRadius.small)
            }
            
            if !viewModel.importError.isEmpty {
                HStack(spacing: Constants.Spacing.small) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                    
                    Text(viewModel.importError)
                        .font(.system(size: Constants.FontSize.small, weight: .regular))
                        .foregroundColor(.red)
                }
                .padding(Constants.Spacing.small)
                .background(Color.red.opacity(0.1))
                .cornerRadius(Constants.CornerRadius.small)
            }
        }
    }
    
    private var statisticsSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.small) {
            Text("Statistics")
                .font(.system(size: Constants.FontSize.body, weight: .semibold))
                .foregroundColor(.primary)
            
            VStack(spacing: Constants.Spacing.small) {
                statisticRow("Properties Loaded", count: viewModel.propertiesLoadedCount, icon: "house.fill")
                statisticRow("Ready to Email", count: viewModel.readyToEmailCount, icon: "checkmark.circle.fill", color: .green)
                statisticRow("Missing Email", count: viewModel.missingEmailCount, icon: "exclamationmark.circle.fill", color: .orange)
                statisticRow("Invalid Email", count: viewModel.invalidEmailCount, icon: "xmark.circle.fill", color: .red)
            }
        }
    }
    
    private func statisticRow(
        _ label: String,
        count: Int,
        icon: String,
        color: Color = .primary
    ) -> some View {
        HStack(spacing: Constants.Spacing.medium) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: Constants.FontSize.body))
            
            Text(label)
                .font(.system(size: Constants.FontSize.small, weight: .regular))
                .foregroundColor(.primary)
            
            Spacer()
            
            Text("\(count)")
                .font(.system(size: Constants.FontSize.body, weight: .semibold))
                .foregroundColor(Constants.brandColor)
        }
        .padding(Constants.Spacing.small)
        .background(Color(nsColor: .textBackgroundColor))
        .cornerRadius(Constants.CornerRadius.small)
    }
    
    private var actionButtonsSection: some View {
        VStack(spacing: Constants.Spacing.small) {
            Button(action: { /* Create Apple Mail Drafts */ }) {
                HStack(spacing: Constants.Spacing.small) {
                    Image(systemName: "envelope.badge.shield.half.filled")
                    Text("Create Apple Mail Drafts")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Constants.brandColor)
            .controlSize(.large)
            .disabled(viewModel.selectedReadyToEmailCount == 0)
            
            Button(action: { viewModel.showSettings = true }) {
                HStack(spacing: Constants.Spacing.small) {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
    }
    
    private var propertyTableSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.small) {
            HStack {
                Text("Properties")
                    .font(.system(size: Constants.FontSize.headline, weight: .semibold))
                
                Spacer()
                
                if viewModel.propertiesLoadedCount > 0 {
                    Button(action: viewModel.selectAllProperties) {
                        Text("Select All")
                            .font(.system(size: Constants.FontSize.small))
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    
                    Button(action: viewModel.deselectAllProperties) {
                        Text("Deselect All")
                            .font(.system(size: Constants.FontSize.small))
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                }
            }
            
            if viewModel.properties.isEmpty {
                VStack(spacing: Constants.Spacing.medium) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)
                    
                    Text("No properties loaded")
                        .font(.system(size: Constants.FontSize.body, weight: .regular))
                        .foregroundColor(.secondary)
                    
                    Text("Import an MTI spreadsheet to get started")
                        .font(.system(size: Constants.FontSize.small, weight: .regular))
                        .foregroundColor(.secondary)
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
            } else {
                PropertyTableView()
                    .environmentObject(viewModel)
            }
        }
    }
    
    private var emailPreviewSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.small) {
            Text("Email Preview")
                .font(.system(size: Constants.FontSize.headline, weight: .semibold))
            
            if let property = viewModel.selectedProperty {
                EmailPreviewView(property: property)
                    .environmentObject(viewModel)
            } else {
                VStack(spacing: Constants.Spacing.medium) {
                    Image(systemName: "envelope")
                        .font(.system(size: 32))
                        .foregroundColor(.secondary)
                    
                    Text("Select a property to preview the email")
                        .font(.system(size: Constants.FontSize.small, weight: .regular))
                        .foregroundColor(.secondary)
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    let viewModel = DashboardViewModel()
    viewModel.updateProperties([
        Property(
            address: "123 Main Street, London",
            tenantName: "John Doe",
            email: "john@example.com",
            isSelected: true
        ),
        Property(
            address: "456 Oak Avenue, Manchester",
            tenantName: "Jane Smith",
            email: "",
            isSelected: false
        ),
        Property(
            address: "789 Elm Road, Birmingham",
            tenantName: "Bob Johnson",
            email: "invalid-email",
            isSelected: true
        )
    ])
    
    return DashboardView()
        .environmentObject(viewModel)
}
