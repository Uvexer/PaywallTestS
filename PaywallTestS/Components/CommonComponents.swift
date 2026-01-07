import SwiftUI

struct PremiumIconView: View {
    let icon: String
    let size: CGFloat
    let glowSize: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: glowSize, height: glowSize)
                .blur(radius: 20)
            
            Circle()
                .fill(Color.white.opacity(0.15))
                .frame(width: size, height: size)
            
            Image(systemName: icon)
                .font(.system(size: size * 0.5))
                .foregroundColor(.white)
        }
    }
}

struct BrandLogoView: View {
    let iconSize: CGFloat
    let fontSize: CGFloat
    let color: Color
    
    var body: some View {
        HStack(spacing: iconSize * 0.25) {
            Image(systemName: .logoIcon)
                .font(.system(size: iconSize))
                .foregroundColor(color)
            
            Text(verbatim: .appName)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundColor(color)
        }
    }
}

struct PageIndicatorView: View {
    let currentPage: Int
    let totalPages: Int
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.small) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(isCurrentPage(index) ? Color.white : Color.white.opacity(0.4))
                    .frame(width: isCurrentPage(index) ? 24 : 8, height: 8)
                    .animation(.spring(response: 0.3), value: currentPage)
            }
        }
    }
    
    private func isCurrentPage(_ index: Int) -> Bool {
        currentPage == index
    }
}

struct GradientButton: View {
    let title: String
    let icon: String?
    let isLoading: Bool
    let action: () -> Void
    
    init(title: String, icon: String? = nil, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppTheme.Spacing.medium) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                        .font(.system(size: AppTheme.FontSize.title, weight: .semibold))
                    
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: AppTheme.FontSize.body, weight: .semibold))
                    }
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppTheme.Spacing.title)
            .background(AppTheme.Colors.orangeGradient)
            .cornerRadius(AppTheme.CornerRadius.medium)
            .shadow(color: AppTheme.Colors.primaryOrange.opacity(0.4), radius: 10, x: 0, y: 5)
        }
        .disabled(isLoading)
    }
}

struct WhiteButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: AppTheme.FontSize.title, weight: .semibold))
                .foregroundColor(AppTheme.Colors.primaryOrange)
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTheme.Spacing.title)
                .background(Color.white)
                .cornerRadius(AppTheme.CornerRadius.medium)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        }
    }
}

struct SubscriptionBadge: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: AppTheme.IconSize.small))
                .foregroundColor(.white)
            
            Text(text)
                .font(.system(size: AppTheme.FontSize.body, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, AppTheme.Spacing.large)
        .padding(.vertical, AppTheme.Spacing.medium)
        .background(AppTheme.Colors.orangeGradient)
        .cornerRadius(AppTheme.CornerRadius.large)
        .shadow(color: AppTheme.Colors.primaryOrange.opacity(0.4), radius: 10, x: 0, y: 5)
    }
}

struct FeatureRowView: View {
    let feature: Feature
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.medium) {
            Image(systemName: feature.icon)
                .foregroundColor(AppTheme.Colors.primaryOrange)
                .font(.system(size: 22, weight: .semibold))
            
            Text(feature.text)
                .font(.system(size: AppTheme.FontSize.body, weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

struct OrangeGradientIcon: View {
    let icon: String
    let size: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .shadow(color: color.opacity(0.4), radius: 8, x: 0, y: 4)
            
            Image(systemName: icon)
                .font(.system(size: size * 0.43, weight: .semibold))
                .foregroundColor(.white)
        }
    }
}

private extension AppTheme.Spacing {
    static let title: CGFloat = 18
}

