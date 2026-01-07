import SwiftUI

struct PaywallView: View {
    @StateObject private var viewModel: PaywallViewModel
    
    init(subscriptionManager: SubscriptionManager) {
        _viewModel = StateObject(wrappedValue: PaywallViewModel(subscriptionManager: subscriptionManager))
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
            scrollContent
        }
    }
}

private extension PaywallView {
    var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 1.0, green: 0.35, blue: 0.0),
                Color(red: 1.0, green: 0.5, blue: 0.1)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    var scrollContent: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection
                whiteContentContainer
            }
        }
    }
    
    var headerSection: some View {
        VStack(spacing: AppTheme.Spacing.medium) {
            brandLogo
            premiumIcon
            titleSection
            descriptionSection
        }
        .padding(.bottom, 40)
    }
    
    var brandLogo: some View {
        BrandLogoView(
            iconSize: AppTheme.IconSize.medium,
            fontSize: AppTheme.FontSize.title,
            color: .white
        )
        .padding(.top, 50)
    }
    
    var premiumIcon: some View {
        PremiumIconView(icon: "crown.fill", size: 100, glowSize: 120)
            .padding(.top, 20)
    }
    
    var titleSection: some View {
        Text("Премиум подписка")
            .font(.system(size: AppTheme.FontSize.hero, weight: .bold))
            .foregroundColor(.white)
    }
    
    var descriptionSection: some View {
        Text("Получите полный доступ ко всем функциям приложения")
            .font(.system(size: AppTheme.FontSize.body, weight: .medium))
            .foregroundColor(.white.opacity(0.9))
            .multilineTextAlignment(.center)
            .lineSpacing(4)
            .padding(.horizontal, 40)
    }
    
    var whiteContentContainer: some View {
        VStack(spacing: AppTheme.Spacing.large) {
            subscriptionPlansSection
            featuresSection
            purchaseButton
            termsSection
        }
        .background(containerBackground)
        .padding(.top, -10)
    }
    
    var subscriptionPlansSection: some View {
        VStack(spacing: AppTheme.Spacing.medium) {
            ForEach([SubscriptionType.yearly, .monthly], id: \.rawValue) { type in
                SubscriptionPlanCard(
                    subscriptionType: type,
                    isSelected: viewModel.selectedPlan == type
                ) {
                    withAnimation(.spring(response: 0.3)) {
                        viewModel.selectPlan(type)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    var featuresSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            ForEach(viewModel.features, id: \.text) { feature in
                FeatureRowView(feature: feature)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
    
    var purchaseButton: some View {
        GradientButton(
            title: "Продолжить",
            icon: "arrow.right",
            isLoading: viewModel.isPurchasing
        ) {
            viewModel.purchaseSubscription()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    var termsSection: some View {
        VStack(spacing: AppTheme.Spacing.small) {
            Text("Отменить можно в любое время")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Text("© 2026 MSTech Company")
                .font(.system(size: AppTheme.FontSize.caption, weight: .medium))
                .foregroundColor(.secondary.opacity(0.7))
        }
        .padding(.vertical, 20)
    }
    
    var containerBackground: some View {
        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.extraLarge)
            .fill(Color(UIColor.systemBackground))
    }
}

