import SwiftUI

enum AppTheme {
    enum Colors {
        static let primaryOrange = Color(red: 1.0, green: 0.4, blue: 0.0)
        static let secondaryOrange = Color(red: 1.0, green: 0.5, blue: 0.1)
        static let lightOrange = Color(red: 1.0, green: 0.6, blue: 0.0)
        static let mediumOrange = Color(red: 1.0, green: 0.45, blue: 0.1)
        
        static let successGreen = Color(red: 0.0, green: 0.8, blue: 0.4)
        static let successGreenLight = Color(red: 0.0, green: 0.9, blue: 0.5)
        
        static var orangeGradient: LinearGradient {
            LinearGradient(
                gradient: Gradient(colors: [primaryOrange, secondaryOrange]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
        
        static var backgroundGradient: LinearGradient {
            LinearGradient(
                gradient: Gradient(colors: [primaryOrange, secondaryOrange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
        
        static var greenGradient: LinearGradient {
            LinearGradient(
                gradient: Gradient(colors: [successGreen, successGreenLight]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
    
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    enum CornerRadius {
        static let small: CGFloat = 12
        static let medium: CGFloat = 16
        static let large: CGFloat = 20
        static let extraLarge: CGFloat = 30
    }
    
    enum FontSize {
        static let caption: CGFloat = 12
        static let body: CGFloat = 16
        static let title: CGFloat = 18
        static let largeTitle: CGFloat = 32
        static let hero: CGFloat = 36
    }
    
    enum IconSize {
        static let small: CGFloat = 20
        static let medium: CGFloat = 28
        static let large: CGFloat = 50
        static let extraLarge: CGFloat = 60
    }
}

extension String {
    static let appName = "MSTech Company"
    static let logoIcon = "bolt.circle.fill"
}

