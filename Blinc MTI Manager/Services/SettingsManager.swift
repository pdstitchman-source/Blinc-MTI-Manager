import Foundation

/// Manages application settings and persistent storage using UserDefaults.
/// Uses the singleton pattern to ensure consistent access throughout the application.
class SettingsManager {
    // MARK: - Singleton Instance
    
    static let shared = SettingsManager()
    
    // MARK: - Constants
    
    private enum StorageKeys {
        static let selectedAgentId = "com.blinc.mtimanager.selectedAgentId"
    }
    
    // MARK: - UserDefaults Access
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Private Initialization
    
    private init() {}
    
    // MARK: - Properties
    
    /// The ID of the currently selected estate agent.
    /// Persists across application launches.
    var selectedAgentId: String? {
        get {
            userDefaults.string(forKey: StorageKeys.selectedAgentId)
        }
        set {
            if let newValue = newValue {
                userDefaults.set(newValue, forKey: StorageKeys.selectedAgentId)
            } else {
                userDefaults.removeObject(forKey: StorageKeys.selectedAgentId)
            }
        }
    }
    
    // MARK: - Public Methods
    
    /// Resets all application settings to their default values.
    func resetAllSettings() {
        selectedAgentId = nil
    }
}
