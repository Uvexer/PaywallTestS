import Foundation

enum SubscriptionType: String, Codable {
    case monthly
    case yearly
    
    var title: String {
        switch self {
        case .monthly: return "Месячная подписка"
        case .yearly: return "Годовая подписка"
        }
    }
    
    var price: String {
        switch self {
        case .monthly: return "990 ₽"
        case .yearly: return "4 990 ₽"
        }
    }
    
    var period: String {
        switch self {
        case .monthly: return "месяц"
        case .yearly: return "год"
        }
    }
    
    var discount: String? {
        switch self {
        case .monthly: return nil
        case .yearly: return "Скидка 50%"
        }
    }
    
    var pricePerMonth: String? {
        switch self {
        case .monthly: return nil
        case .yearly: return "~416 ₽/месяц"
        }
    }
}

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
}

struct Feature {
    let icon: String
    let text: String
}

struct ContentItem {
    let icon: String
    let title: String
    let description: String
    let colorIndex: Int
}

extension OnboardingPage {
    static let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "star.circle.fill",
            title: "Добро пожаловать",
            description: "Откройте для себя все возможности приложения с премиум подпиской от MSTech"
        ),
        OnboardingPage(
            icon: "crown.fill",
            title: "Премиум опыт",
            description: "Получите доступ ко всем функциям и эксклюзивному контенту без ограничений"
        )
    ]
}

extension Feature {
    static let premiumFeatures: [Feature] = [
        Feature(icon: "checkmark.circle.fill", text: "Полный доступ к контенту"),
        Feature(icon: "checkmark.circle.fill", text: "Без рекламы"),
        Feature(icon: "checkmark.circle.fill", text: "Эксклюзивные материалы"),
        Feature(icon: "checkmark.circle.fill", text: "Приоритетная поддержка")
    ]
}

extension ContentItem {
    static let mainContent: [ContentItem] = [
        ContentItem(icon: "book.fill", title: "Эксклюзивные статьи", description: "Доступ к премиум контенту и материалам", colorIndex: 0),
        ContentItem(icon: "play.circle.fill", title: "Видео уроки", description: "Обучающие видео от профессионалов", colorIndex: 1),
        ContentItem(icon: "chart.line.uptrend.xyaxis", title: "Аналитика", description: "Подробная статистика и отчеты", colorIndex: 2),
        ContentItem(icon: "bell.badge.fill", title: "Уведомления", description: "Получайте важные обновления первыми", colorIndex: 3)
    ]
}

