import SwiftUI

/// Displays a preview of the email that will be sent for the selected property.
struct EmailPreviewView: View {
    // MARK: - Environment Objects
    
    @EnvironmentObject var viewModel: DashboardViewModel
    
    // MARK: - Properties
    
    let property: Property
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            // Email headers section
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                HStack {
                    Text("To:")
                        .font(.system(size: Constants.FontSize.small, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                    Text(property.email.isEmpty ? "(no email)" : property.email)
                        .font(.system(size: Constants.FontSize.small, weight: .regular))
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                
                Divider()
                    .padding(.vertical, Constants.Spacing.extraSmall)
                
                HStack {
                    Text("Subject:")
                        .font(.system(size: Constants.FontSize.small, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.generateEmailSubject(for: property))
                        .font(.system(size: Constants.FontSize.small, weight: .regular))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Spacer()
                }
            }
            .padding(Constants.Spacing.medium)
            .background(Color(nsColor: .textBackgroundColor))
            .cornerRadius(Constants.CornerRadius.small)
            
            // Email body section
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                Text("Body:")
                    .font(.system(size: Constants.FontSize.small, weight: .semibold))
                    .foregroundColor(.secondary)
                
                ScrollView {
                    Text(viewModel.generateEmailBody(for: property))
                        .font(.system(size: Constants.FontSize.small, weight: .regular, design: .default))
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .textSelection(.enabled)
                        .padding(Constants.Spacing.medium)
                }
                .frame(maxHeight: .infinity)
                .background(Color(nsColor: .textBackgroundColor))
                .cornerRadius(Constants.CornerRadius.small)
            }
            
            // Status indicator
            if property.status != .ready {
                HStack(spacing: Constants.Spacing.small) {
                    Image(systemName: property.status.symbolName)
                        .foregroundColor(Color(property.status.color))
                    
                    Text("This email cannot be sent: \(property.status.displayName)")
                        .font(.system(size: Constants.FontSize.small, weight: .regular))
                        .foregroundColor(Color(property.status.color))
                }
                .padding(Constants.Spacing.medium)
                .background(Color(property.status.color).opacity(0.1))
                .cornerRadius(Constants.CornerRadius.small)
            }
        }
    }
}

#Preview {
    let viewModel = DashboardViewModel()
    
    return EmailPreviewView(
        property: Property(
            address: "123 Main Street, London",
            tenantName: "John Doe",
            email: "john@example.com"
        )
    )
    .environmentObject(viewModel)
    .padding(Constants.Spacing.large)
}
