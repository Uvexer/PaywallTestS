import SwiftUI

@main
struct PaywallTestSApp: App {
    @StateObject private var subscriptionManager = SubscriptionManager()
    
    var body: some Scene {
        WindowGroup {
            RootView(subscriptionManager: subscriptionManager)
        }
    }
}

struct RootView: View {
    @ObservedObject var subscriptionManager: SubscriptionManager
    
    var body: some View {
        Group {
            if subscriptionManager.hasActiveSubscription {
                MainView(subscriptionManager: subscriptionManager)
            } else if subscriptionManager.hasCompletedOnboarding {
                PaywallView(subscriptionManager: subscriptionManager)
            } else {
                OnboardingView(subscriptionManager: subscriptionManager)
            }
        }
    }
}

