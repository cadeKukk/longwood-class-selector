import SwiftUI

struct Toast: Equatable {
    enum ToastStyle {
        case error
        case warning
        case success
        case `default`
        
        var themeColor: Color {
            switch self {
            case .error: return Color.red
            case .warning: return Color.orange
            case .success: return LongwoodTheme.success
            case .default: return LongwoodTheme.primaryBlue
            }
        }
        
        var iconName: String {
            switch self {
            case .error: return "xmark.circle.fill"
            case .warning: return "exclamationmark.triangle.fill"
            case .success: return "checkmark.circle.fill"
            case .default: return "info.circle.fill"
            }
        }
    }
    
    let style: ToastStyle
    let message: String
    
    static func == (lhs: Toast, rhs: Toast) -> Bool {
        return lhs.message == rhs.message && lhs.style == rhs.style
    }
}

class ToastManager: ObservableObject {
    @Published var toast: Toast? = nil
    @Published var showToast: Bool = false
    
    static let shared = ToastManager()
    
    private init() {}
    
    func show(toast: Toast) {
        withAnimation {
            self.toast = toast
            self.showToast = true
        }
        
        // Auto hide after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showToast = false
            }
        }
    }
    
    func hide() {
        withAnimation {
            self.showToast = false
        }
    }
}

struct ToastView: View {
    var toast: Toast
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: toast.style.iconName)
                .foregroundColor(.white)
            
            Text(toast.message)
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button(action: {
                ToastManager.shared.hide()
            }) {
                Image(systemName: "xmark")
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(toast.style.themeColor)
        )
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
        .padding(.horizontal, LongwoodTheme.defaultPadding)
        .padding(.bottom, 8)
    }
} 