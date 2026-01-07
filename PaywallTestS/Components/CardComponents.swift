import SwiftUI

struct SubscriptionPlanCard: View {
    let subscriptionType: SubscriptionType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                headerSection
                priceSection
            }
            .padding(AppTheme.Spacing.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cardBackground)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

private extension SubscriptionPlanCard {
    var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(subscriptionType.title)
                    .font(.system(size: AppTheme.FontSize.title, weight: .bold))
                    .foregroundColor(.primary)
                
                if let pricePerMonth = subscriptionType.pricePerMonth {
                    Text(pricePerMonth)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            if let discount = subscriptionType.discount {
                discountBadge(text: discount)
            }
        }
    }
    
    var priceSection: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(subscriptionType.price)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(AppTheme.Colors.primaryOrange)
            
            Text("/ \(subscriptionType.period)")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
        }
    }
    
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
            .fill(Color(UIColor.secondarySystemBackground))
            .overlay(borderOverlay)
            .shadow(color: shadowColor, radius: 10, x: 0, y: 5)
    }
    
    var borderOverlay: some View {
        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
            .strokeBorder(borderGradient, lineWidth: 3)
    }
    
    var borderGradient: LinearGradient {
        isSelected ? AppTheme.Colors.orangeGradient : transparentGradient
    }
    
    var transparentGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.clear, Color.clear]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    var shadowColor: Color {
        isSelected ? AppTheme.Colors.primaryOrange.opacity(0.3) : Color.clear
    }
    
    func discountBadge(text: String) -> some View {
        Text(text)
            .font(.system(size: AppTheme.FontSize.caption, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, AppTheme.Spacing.medium)
            .padding(.vertical, 6)
            .background(AppTheme.Colors.greenGradient)
            .cornerRadius(AppTheme.CornerRadius.small)
            .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct ContentCardView: View {
    let item: ContentItem
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.medium) {
            iconSection
            textSection
            Spacer(minLength: 0)
        }
        .padding(AppTheme.Spacing.title)
        .background(cardBackground)
    }
}

private extension ContentCardView {
    var iconSection: some View {
        OrangeGradientIcon(
            icon: item.icon,
            size: 65,
            color: getColor(for: item.colorIndex)
        )
    }
    
    var textSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.title)
                .font(.system(size: AppTheme.FontSize.title, weight: .bold))
                .foregroundColor(.primary)
            
            Text(item.description)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
            .fill(Color(UIColor.secondarySystemBackground))
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
    
    func getColor(for index: Int) -> Color {
        let colors = [
            AppTheme.Colors.primaryOrange,
            Color(red: 1.0, green: 0.5, blue: 0.0),
            AppTheme.Colors.lightOrange,
            AppTheme.Colors.mediumOrange
        ]
        return colors[index % colors.count]
    }
}

private extension AppTheme.Spacing {
    static let title: CGFloat = 18
}

