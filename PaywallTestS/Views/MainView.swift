import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel
    
    init(subscriptionManager: SubscriptionManager) {
        _viewModel = StateObject(wrappedValue: MainViewModel(subscriptionManager: subscriptionManager))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                scrollContent
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Сбросить подписку?", isPresented: resetAlertBinding) {
                alertButtons
            } message: {
                alertMessage
            }
        }
    }
}

private extension MainView {
    var resetAlertBinding: Binding<Bool> {
        Binding(
            get: { viewModel.showingResetAlert },
            set: { if !$0 { viewModel.hideResetAlert() } }
        )
    }
    
    var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                AppTheme.Colors.primaryOrange.opacity(0.15),
                Color(UIColor.systemBackground)
            ]),
            startPoint: .top,
            endPoint: .center
        )
        .ignoresSafeArea()
    }
    
    var scrollContent: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.large) {
                heroSection
                contentCardsSection
                footerSection
            }
        }
    }
    
    var heroSection: some View {
        VStack(spacing: 20) {
            brandLogo
            premiumBadge
            welcomeTitle
            
            if let subscriptionText = viewModel.subscriptionTypeText {
                SubscriptionBadge(text: subscriptionText)
            }
        }
        .padding(.bottom, 10)
    }
    
    var brandLogo: some View {
        BrandLogoView(
            iconSize: AppTheme.IconSize.large,
            fontSize: 20,
            color: AppTheme.Colors.primaryOrange
        )
        .padding(.top, 20)
    }
    
    var premiumBadge: some View {
        ZStack {
            Circle()
                .fill(AppTheme.Colors.orangeGradient)
                .frame(width: 100, height: 100)
                .shadow(color: AppTheme.Colors.primaryOrange.opacity(0.4), radius: 20, x: 0, y: 10)
            
            Image(systemName: "crown.fill")
                .font(.system(size: 50))
                .foregroundColor(.white)
        }
    }
    
    var welcomeTitle: some View {
        Text("Добро пожаловать!")
            .font(.system(size: AppTheme.FontSize.largeTitle, weight: .bold))
            .foregroundColor(.primary)
    }
    
    var contentCardsSection: some View {
        VStack(spacing: AppTheme.Spacing.medium) {
            ForEach(viewModel.contentItems.indices, id: \.self) { index in
                ContentCardView(item: viewModel.contentItems[index])
            }
        }
        .padding(.horizontal, 20)
    }
    
    var footerSection: some View {
        VStack(spacing: AppTheme.Spacing.medium) {
            copyrightText
            resetButton
        }
        .padding(.top, 20)
        .padding(.bottom, 30)
    }
    
    var copyrightText: some View {
        Text("© 2026 MSTech Company")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.secondary)
    }
    
    var resetButton: some View {
        Button(action: viewModel.showResetAlert) {
            Text("Сбросить подписку (для теста)")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.red.opacity(0.7))
        }
    }
    
    var alertButtons: some View {
        Group {
            Button("Отмена", role: .cancel) {
                viewModel.hideResetAlert()
            }
            Button("Сбросить", role: .destructive) {
                viewModel.resetSubscription()
            }
        }
    }
    
    var alertMessage: some View {
        Text("Это действие вернёт вас к началу онбординга")
    }
}

