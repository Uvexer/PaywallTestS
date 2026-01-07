import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel
    
    init(subscriptionManager: SubscriptionManager) {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(subscriptionManager: subscriptionManager))
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
            contentView
        }
    }
}

private extension OnboardingView {
    var backgroundGradient: some View {
        AppTheme.Colors.backgroundGradient
            .ignoresSafeArea()
    }
    
    var contentView: some View {
        VStack(spacing: 0) {
            headerSection
            Spacer()
            pageIndicator
            pageContent
            Spacer()
            continueButton
        }
    }
    
    var headerSection: some View {
        VStack(spacing: AppTheme.Spacing.small) {
            Image(systemName: .logoIcon)
                .font(.system(size: AppTheme.IconSize.large))
                .foregroundColor(.white)
            
            Text(verbatim: .appName)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.top, 60)
    }
    
    var pageIndicator: some View {
        PageIndicatorView(
            currentPage: viewModel.currentPage,
            totalPages: viewModel.totalPages
        )
        .padding(.bottom, 30)
    }
    
    var pageContent: some View {
        OnboardingPageContentView(page: viewModel.currentPageData)
            .transition(.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            ))
            .id(viewModel.currentPage)
    }
    
    var continueButton: some View {
        WhiteButton(title: "Продолжить") {
            withAnimation(.spring(response: 0.5)) {
                viewModel.continueAction()
            }
        }
        .padding(.horizontal, AppTheme.Spacing.extraLarge)
        .padding(.bottom, 50)
    }
}

struct OnboardingPageContentView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: AppTheme.Spacing.large) {
            iconSection
            titleSection
            descriptionSection
        }
        .padding(.vertical, 20)
    }
}

private extension OnboardingPageContentView {
    var iconSection: some View {
        PremiumIconView(
            icon: page.icon,
            size: 120,
            glowSize: 140
        )
    }
    
    var titleSection: some View {
        Text(page.title)
            .font(.system(size: AppTheme.FontSize.hero, weight: .bold))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
    
    var descriptionSection: some View {
        Text(page.description)
            .font(.system(size: AppTheme.FontSize.title, weight: .medium))
            .foregroundColor(.white.opacity(0.9))
            .multilineTextAlignment(.center)
            .lineSpacing(4)
            .padding(.horizontal, 40)
    }
}

