import Foundation
import Combine

final class PaywallViewModel: ObservableObject {
    @Published private(set) var selectedPlan: SubscriptionType = .yearly
    @Published private(set) var isPurchasing: Bool = false
    
    private let subscriptionManager: SubscriptionManager
    private let purchaseDelay: TimeInterval = 1.5
    
    var features: [Feature] {
        Feature.premiumFeatures
    }
    
    init(subscriptionManager: SubscriptionManager) {
        self.subscriptionManager = subscriptionManager
    }
    
    func selectPlan(_ plan: SubscriptionType) {
        selectedPlan = plan
    }
    
    func purchaseSubscription() {
        guard !isPurchasing else { return }
        
        isPurchasing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + purchaseDelay) { [weak self] in
            guard let self = self else { return }
            self.subscriptionManager.purchaseSubscription(type: self.selectedPlan)
            self.isPurchasing = false
        }
    }
}

