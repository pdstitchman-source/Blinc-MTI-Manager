import SwiftUI

/// Displays a table of properties with selection checkboxes and status indicators.
struct PropertyTableView: View {
    // MARK: - Environment Objects
    
    @EnvironmentObject var viewModel: DashboardViewModel
    
    // MARK: - Body
    
    var body: some View {
        Table(viewModel.properties, selection: $viewModel.selectedProperty) {
            TableColumn("Select", value: \.address) { property in
                Button(action: { viewModel.togglePropertySelection(property) }) {
                    Image(systemName: property.isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(property.isSelected ? Constants.brandColor : .secondary)
                }
                .buttonStyle(.plain)
            }
            .width(50)
            
            TableColumn("Address", value: \.address) { property in
                Text(property.address)
                    .font(.system(size: Constants.FontSize.body, weight: .regular))
                    .lineLimit(1)
            }
            .width(ideal: 250)
            
            TableColumn("Tenant", value: \.tenantName) { property in
                Text(property.tenantName)
                    .font(.system(size: Constants.FontSize.body, weight: .regular))
                    .lineLimit(1)
            }
            .width(ideal: 150)
            
            TableColumn("Email", value: \.email) { property in
                Text(property.email)
                    .font(.system(size: Constants.FontSize.small, weight: .regular))
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }
            .width(ideal: 200)
            
            TableColumn("Status", value: \.status.rawValue) { property in
                HStack(spacing: Constants.Spacing.extraSmall) {
                    Image(systemName: property.status.symbolName)
                        .font(.system(size: Constants.FontSize.body, weight: .semibold))
                        .foregroundColor(Color(property.status.color))
                    
                    Text(property.status.displayName)
                        .font(.system(size: Constants.FontSize.small, weight: .regular))
                        .lineLimit(1)
                }
            }
            .width(ideal: 130)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        )
    ])
    
    return PropertyTableView()
        .environmentObject(viewModel)
        .frame(height: 300)
}
