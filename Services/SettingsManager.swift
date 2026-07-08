import Foundation

final class SettingsManager {

    static let shared = SettingsManager()

    private let key = "SelectedEstateAgent"

    func save(agent: String) {
        UserDefaults.standard.set(agent, forKey: key)
    }

    func loadAgent() -> String {
        UserDefaults.standard.string(forKey: key) ?? "Harringtons"
    }

}
