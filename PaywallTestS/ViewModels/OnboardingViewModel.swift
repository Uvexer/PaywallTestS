import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {
    @Published private(set) var currentPage: Int = 0
    
    private let subscriptionManager: SubscriptionManager
    private let pages = OnboardingPage.pages
    
    var totalPages: Int {
        pages.count
    }
    
    var currentPageData: OnboardingPage {
        pages[currentPage]
    }
    
    init(subscriptionManager: SubscriptionManager) {
        self.subscriptionManager = subscriptionManager
    }
    
    func continueAction() {
        if isLastPage {
            completeOnboarding()
        } else {
            goToNextPage()
        }
    }
    
    private func goToNextPage() {
        guard currentPage < pages.count - 1 else { return }
        currentPage += 1
    }
    
    private func completeOnboarding() {
        subscriptionManager.completeOnboarding()
    }
    
    private var isLastPage: Bool {
        currentPage == pages.count - 1
    }
}

