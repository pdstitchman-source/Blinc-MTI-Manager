import Foundation
import Combine

/// ViewModel for the main dashboard view.
/// Handles state management for properties, agent selection, spreadsheet import, and statistics.
@MainActor
class DashboardViewModel: NSObject, ObservableObject {
    // MARK: - Published Properties
    
    /// The currently selected estate agent.
    @Published var selectedAgent: EstateAgent = .lettingLand {
        didSet {
            SettingsManager.shared.selectedAgentId = selectedAgent.id
        }
    }
    
    /// Array of all loaded properties from the imported spreadsheet.
    @Published var properties: [Property] = []
    
    /// The currently selected property for preview and editing.
    @Published var selectedProperty: Property?
    
    /// The name of the currently imported spreadsheet file.
    @Published var importedFileName: String = ""
    
    /// Indicates whether a file import operation is in progress.
    @Published var isImporting: Bool = false
    
    /// Error message if an import fails.
    @Published var importError: String = ""
    
    // MARK: - Computed Properties
    
    /// The total number of properties loaded.
    var propertiesLoadedCount: Int {
        properties.count
    }
    
    /// The count of properties ready to email.
    var readyToEmailCount: Int {
        properties.filter { $0.status == .ready }.count
    }
    
    /// The count of properties with missing email addresses.
    var missingEmailCount: Int {
        properties.filter { $0.status == .missingEmail }.count
    }
    
    /// The count of properties with invalid email addresses.
    var invalidEmailCount: Int {
        properties.filter { $0.status == .invalidEmail }.count
    }
    
    /// The count of selected properties ready to email.
    var selectedReadyToEmailCount: Int {
        properties.filter { $0.isSelected && $0.status == .ready }.count
    }
    
    /// Indicates whether any properties are currently selected.
    var hasSelectedProperties: Bool {
        properties.contains { $0.isSelected }
    }
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        // Restore previously selected agent from UserDefaults
        if let savedAgentId = SettingsManager.shared.selectedAgentId,
           let savedAgent = EstateAgent.allAgents.first(where: { $0.id == savedAgentId }) {
            self.selectedAgent = savedAgent
        }
    }
    
    // MARK: - Public Methods
    
    /// Toggles the selection state of a property.
    /// - Parameter property: The property to toggle
    func togglePropertySelection(_ property: Property) {
        if let index = properties.firstIndex(where: { $0.id == property.id }) {
            properties[index].isSelected.toggle()
        }
    }
    
    /// Selects all properties.
    func selectAllProperties() {
        properties = properties.map { var property = $0
            property.isSelected = true
            return property
        }
    }
    
    /// Deselects all properties.
    func deselectAllProperties() {
        properties = properties.map { var property = $0
            property.isSelected = false
            return property
        }
    }
    
    /// Generates the email subject for a given property.
    /// - Parameter property: The property for which to generate the subject
    /// - Returns: The formatted email subject
    func generateEmailSubject(for property: Property) -> String {
        "Mid Term Inspection for \(property.address)"
    }
    
    /// Generates the email body for a given property.
    /// - Parameter property: The property for which to generate the body
    /// - Returns: The formatted email body
    func generateEmailBody(for property: Property) -> String {
        """
        Hi,
        
        We have been instructed by \(selectedAgent.name) to arrange a property inspection at \(property.address)
        
        Please can we ask that you email us with some dates and times when you will be home to allow us access for this appointment which should only take around 10 minutes.
        
        A mid-term inspection is a formal check of your property during tenancy to ensure the ongoing maintenance of the property. You will have the opportunity to highlight any issues that might otherwise go amiss.
        
        So you know, things we will be looking out for are:
        
        • Dampness & mould
        • Leaks
        • General condition of property fittings
        • Cleanliness
        • Condition of garden if applicable
        • Smoke alarms and carbon monoxide detectors, are they fitted and working?
        
        We look forward to hearing from you.
        
        Kind Regards
        
        Blinc Property Reports
        
        info@blincreports.co.uk
        
        www.blincreports.co.uk
        """
    }
    
    /// Updates the properties list with new data.
    /// - Parameter newProperties: The new properties to load
    func updateProperties(_ newProperties: [Property]) {
        self.properties = newProperties
        self.selectedProperty = newProperties.first
    }
    
    /// Clears all loaded properties and import information.
    func clearProperties() {
        properties.removeAll()
        importedFileName = ""
        selectedProperty = nil
    }
}
