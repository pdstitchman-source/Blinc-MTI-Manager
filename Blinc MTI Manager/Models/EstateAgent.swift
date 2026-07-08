import Foundation

/// Represents an estate agent for the Blinc Property Reports system.
/// - Note: This model conforms to Codable for potential future persistence needs.
struct EstateAgent: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    
    // MARK: - Predefined Agents
    
    static let lettingLand = EstateAgent(id: "letting-land", name: "Letting Land")
    static let harringtons = EstateAgent(id: "harringtons", name: "Harringtons")
    static let jamesDean = EstateAgent(id: "james-dean", name: "James Dean")
    static let choices = EstateAgent(id: "choices", name: "Choices")
    static let kaybridge = EstateAgent(id: "kaybridge", name: "Kaybridge")
    static let greenfield = EstateAgent(id: "greenfield", name: "Greenfield")
    static let birdhouseSurrey = EstateAgent(id: "birdhouse-surrey", name: "Birdhouse Surrey")
    static let knights = EstateAgent(id: "knights", name: "Knights")
    static let zoom = EstateAgent(id: "zoom", name: "Zoom")
    
    /// All available estate agents in order of presentation.
    static let allAgents: [EstateAgent] = [
        .lettingLand,
        .harringtons,
        .jamesDean,
        .choices,
        .kaybridge,
        .greenfield,
        .birdhouseSurrey,
        .knights,
        .zoom
    ]
}
