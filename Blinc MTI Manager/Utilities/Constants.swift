import SwiftUI

/// Application-wide constants and configuration values.
enum Constants {
    // MARK: - Branding
    
    /// The primary brand color for the Blinc Property Reports application.
    static let brandColor = Color(red: 0.0, green: 0.682, blue: 1.0) // #00AEFF
    
    // MARK: - Spacing
    
    enum Spacing {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    
    enum CornerRadius {
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
    }
    
    // MARK: - Font Sizes
    
    enum FontSize {
        static let caption: CGFloat = 11
        static let small: CGFloat = 12
        static let body: CGFloat = 14
        static let title: CGFloat = 16
        static let headline: CGFloat = 18
        static let largeTitle: CGFloat = 24
    }
    
    // MARK: - Window Sizing
    
    enum WindowSize {
        static let minWidth: CGFloat = 1200
        static let minHeight: CGFloat = 800
        static let idealpreferedWidth: CGFloat = 1400
        static let idealpreferedHeight: CGFloat = 900
    }
    
    // MARK: - Table Configuration
    
    enum Table {
        static let minColumnWidth: CGFloat = 100
        static let rowHeight: CGFloat = 28
    }
    
    // MARK: - Email Configuration
    
    enum Email {
        static let supportEmail = "info@blincreports.co.uk"
        static let websiteURL = "www.blincreports.co.uk"
        static let companyName = "Blinc Property Reports"
    }
}
