import Foundation
import Combine

protocol SubscriptionService {
    var hasActiveSubscription: Bool { get }
    var hasCompletedOnboarding: Bool { get }
    var subscriptionType: SubscriptionType? { get }
    
    func completeOnboarding()
    func purchaseSubscription(type: SubscriptionType)
    func resetSubscription()
}

final class SubscriptionManager: ObservableObject, SubscriptionService {
    @Published private(set) var hasActiveSubscription: Bool = false
    @Published private(set) var hasCompletedOnboarding: Bool = false
    @Published private(set) var subscriptionType: SubscriptionType?
    
    private let storage: UserDefaultsStorage
    
    init(storage: UserDefaultsStorage = .shared) {
        self.storage = storage
        loadSubscriptionState()
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        storage.setOnboardingCompleted(true)
    }
    
    func purchaseSubscription(type: SubscriptionType) {
        hasActiveSubscription = true
        subscriptionType = type
        storage.setSubscription(active: true, type: type)
    }
    
    func resetSubscription() {
        hasActiveSubscription = false
        hasCompletedOnboarding = false
        subscriptionType = nil
        storage.clearAll()
    }
}

private extension SubscriptionManager {
    func loadSubscriptionState() {
        hasActiveSubscription = storage.hasActiveSubscription()
        hasCompletedOnboarding = storage.hasCompletedOnboarding()
        subscriptionType = storage.getSubscriptionType()
    }
}

final class UserDefaultsStorage {
    static let shared = UserDefaultsStorage()
    
    private let hasSubscriptionKey = "hasActiveSubscription"
    private let hasOnboardingKey = "hasCompletedOnboarding"
    private let subscriptionTypeKey = "subscriptionType"
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func hasActiveSubscription() -> Bool {
        defaults.bool(forKey: hasSubscriptionKey)
    }
    
    func hasCompletedOnboarding() -> Bool {
        defaults.bool(forKey: hasOnboardingKey)
    }
    
    func getSubscriptionType() -> SubscriptionType? {
        guard let rawValue = defaults.string(forKey: subscriptionTypeKey) else {
            return nil
        }
        return SubscriptionType(rawValue: rawValue)
    }
    
    func setOnboardingCompleted(_ completed: Bool) {
        defaults.set(completed, forKey: hasOnboardingKey)
    }
    
    func setSubscription(active: Bool, type: SubscriptionType) {
        defaults.set(active, forKey: hasSubscriptionKey)
        defaults.set(type.rawValue, forKey: subscriptionTypeKey)
    }
    
    func clearAll() {
        defaults.set(false, forKey: hasSubscriptionKey)
        defaults.set(false, forKey: hasOnboardingKey)
        defaults.removeObject(forKey: subscriptionTypeKey)
    }
}

