import Foundation

/// Represents a property requiring a Mid-Term Inspection (MTI).
/// - Note: Properties are identified by their address as the primary key.
struct Property: Identifiable, Codable, Hashable {
    let id: UUID
    let address: String
    let tenantName: String
    let email: String
    
    /// The current status of the property's email readiness.
    var status: EmailStatus
    
    /// Indicates whether this property should be included when sending emails.
    var isSelected: Bool = false
    
    /// Initializes a new Property with automatic status determination based on email validity.
    /// - Parameters:
    ///   - id: Unique identifier (defaults to new UUID)
    ///   - address: Property address
    ///   - tenantName: Name of the tenant
    ///   - email: Email address for the tenant
    ///   - isSelected: Whether the property is selected for mailing (defaults to false)
    init(
        id: UUID = UUID(),
        address: String,
        tenantName: String,
        email: String,
        isSelected: Bool = false
    ) {
        self.id = id
        self.address = address
        self.tenantName = tenantName
        self.email = email
        self.isSelected = isSelected
        self.status = Self.determineStatus(for: email)
    }
    
    /// Determines the email status based on the email address validity.
    /// - Parameter email: The email address to validate
    /// - Returns: The appropriate EmailStatus
    private static func determineStatus(for email: String) -> EmailStatus {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .missingEmail
        }
        
        return isValidEmail(email) ? .ready : .invalidEmail
    }
    
    /// Validates an email address using a basic pattern matching approach.
    /// - Note: This uses a pragmatic regex pattern suitable for most valid email addresses.
    /// - Parameter email: The email address to validate
    /// - Returns: True if the email appears valid
    private static func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return predicate.evaluate(with: email)
    }
}

/// Represents the email readiness status of a property.
enum EmailStatus: String, Codable, CaseIterable {
    case ready = "Ready"
    case missingEmail = "Missing Email"
    case invalidEmail = "Invalid Email"
    
    /// A user-friendly description of the status.
    var displayName: String {
        self.rawValue
    }
    
    /// The SF Symbol name appropriate for this status.
    var symbolName: String {
        switch self {
        case .ready:
            return "checkmark.circle.fill"
        case .missingEmail:
            return "exclamationmark.circle.fill"
        case .invalidEmail:
            return "xmark.circle.fill"
        }
    }
    
    /// The color associated with this status.
    /// - Note: Uses standard semantic colors that adapt to light/dark mode.
    var color: String {
        switch self {
        case .ready:
            return "green"
        case .missingEmail:
            return "orange"
        case .invalidEmail:
            return "red"
        }
    }
}
