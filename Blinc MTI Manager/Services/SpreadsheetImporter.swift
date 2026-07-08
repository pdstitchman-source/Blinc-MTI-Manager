import Foundation

/// Service responsible for managing spreadsheet import operations.
/// Handles file selection and validation without parsing content.
class SpreadsheetImporter {
    // MARK: - Properties
    
    /// The currently selected spreadsheet file URL.
    private(set) var selectedFileURL: URL?
    
    /// The display name of the selected file.
    var selectedFileName: String {
        selectedFileURL?.lastPathComponent ?? ""
    }
    
    /// Indicates whether a file is currently selected.
    var hasSelectedFile: Bool {
        selectedFileURL != nil
    }
    
    // MARK: - Public Methods
    
    /// Opens a macOS file picker dialog restricted to .xlsx files.
    /// - Parameter completion: Closure called when file selection completes with optional URL
    func selectSpreadsheetFile(completion: @escaping (URL?) -> Void) {\n        let openPanel = NSOpenPanel()\n        openPanel.allowedFileTypes = [\"xlsx\", \"com.microsoft.excel.sheet\"]\n        openPanel.allowsMultipleSelection = false\n        openPanel.canChooseDirectories = false\n        openPanel.canChooseFiles = true\n        openPanel.message = \"Select an MTI Spreadsheet\"\n        openPanel.prompt = \"Select\"\n        openPanel.title = \"Import MTI Spreadsheet\"\n        \n        openPanel.begin { response in\n            if response == .OK, let url = openPanel.urls.first {\n                self.selectedFileURL = url\n                completion(url)\n            } else {\n                completion(nil)\n            }\n        }\n    }\n    \n    /// Clears the currently selected file.\n    func clearSelection() {\n        selectedFileURL = nil\n    }\n}\n