import SwiftUI

/// Displays a table of properties with selection, search, sorting, and status indicators.
struct PropertyTableView: View {
    // MARK: - Environment Objects
    
    @EnvironmentObject var viewModel: DashboardViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: Constants.Spacing.small) {
            // Search box
            SearchBox(text: $viewModel.searchText)
            
            // Properties table
            if viewModel.filteredProperties.isEmpty {
                emptyStateView
            } else {
                propertyTable
            }
        }
    }
    
    // MARK: - Private Views
    
    private var searchBox: some View {
        HStack(spacing: Constants.Spacing.small) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search by address, tenant, or email", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
            
            if !viewModel.searchText.isEmpty {
                Button(action: { viewModel.searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(Constants.Spacing.small)
        .background(Color(nsColor: .textBackgroundColor))
        .cornerRadius(Constants.CornerRadius.small)
    }
    
    private var propertyTable: some View {
        Table(viewModel.filteredProperties, selection: $viewModel.selectedProperty) {
            // Select column
            TableColumn("Select", value: \.address) { property in
                Button(action: { viewModel.togglePropertySelection(property) }) {
                    Image(systemName: property.isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(property.isSelected ? Constants.brandColor : .secondary)
                }
                .buttonStyle(.plain)
                .help(property.isSelected ? "Deselect property" : "Select property")
            }
            .width(50)
            
            // Address column
            TableColumn("Address", value: \.address) { property in
                Text(property.address)
                    .font(.system(size: Constants.FontSize.body, weight: .regular))
                    .lineLimit(1)
            }
            .width(ideal: 250)
            
            // Tenant column
            TableColumn("Tenant", value: \.tenantName) { property in
                Text(property.tenantName)
                    .font(.system(size: Constants.FontSize.body, weight: .regular))
                    .lineLimit(1)
            }
            .width(ideal: 150)
            
            // Email column
            TableColumn("Email", value: \.email) { property in
                Text(property.email)
                    .font(.system(size: Constants.FontSize.small, weight: .regular))
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }
            .width(ideal: 200)
            
            // Status column
            TableColumn("Status", value: \.status.rawValue) { property in
                statusBadge(for: property.status)
            }
            .width(ideal: 150)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: Constants.Spacing.medium) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 32))
                .foregroundColor(.secondary)
            
            Text("No results found")
                .font(.system(size: Constants.FontSize.body, weight: .semibold))
                .foregroundColor(.secondary)
            
            Text("Try adjusting your search criteria")
                .font(.system(size: Constants.FontSize.small, weight: .regular))
                .foregroundColor(.secondary)
        }
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
    }
    
    private func statusBadge(for status: EmailStatus) -> some View {
        HStack(spacing: Constants.Spacing.extraSmall) {
            Image(systemName: status.symbolName)
                .font(.system(size: Constants.FontSize.body, weight: .semibold))
            
            Text(status.displayName)
                .font(.system(size: Constants.FontSize.small, weight: .regular))
        }
        .foregroundColor(Color(status.color))
        .padding(.horizontal, Constants.Spacing.small)
        .padding(.vertical, Constants.Spacing.extraSmall)
        .background(Color(status.color).opacity(0.15))
        .cornerRadius(Constants.CornerRadius.small)
    }
}

// MARK: - Search Box Component

/// A reusable search input field.
private struct SearchBox: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: Constants.Spacing.small) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search by address, tenant, or email", text: $text)
                .textFieldStyle(.plain)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(Constants.Spacing.small)
        .background(Color(nsColor: .textBackgroundColor))
        .cornerRadius(Constants.CornerRadius.small)
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
            isSelected: false
        ),
        Property(
            address: "42 Brick Lane, Leeds",
            tenantName: "Alice Brown",
            email: "alice.brown@email.com",
            isSelected: false
        )
    ])
    
    return PropertyTableView()
        .environmentObject(viewModel)
        .frame(height: 400)
}
