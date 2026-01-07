import Foundation
import Combine

final class MainViewModel: ObservableObject {
    @Published private(set) var showingResetAlert: Bool = false
    
    private let subscriptionManager: SubscriptionManager
    
    var subscriptionTypeText: String? {
        subscriptionManager.subscriptionType?.title
    }
    
    var contentItems: [ContentItem] {
        ContentItem.mainContent
    }
    
    init(subscriptionManager: SubscriptionManager) {
        self.subscriptionManager = subscriptionManager
    }
    
    func showResetAlert() {
        showingResetAlert = true
    }
    
    func hideResetAlert() {
        showingResetAlert = false
    }
    
    func resetSubscription() {
        subscriptionManager.resetSubscription()
    }
}

