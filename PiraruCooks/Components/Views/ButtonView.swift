import SwiftUI
import Parintins

struct ButtonView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State var viewModel: ButtonViewModel
    
    var body: some View {
        Button {
            viewModel.action()
        } label: {
            Text(viewModel.text)
                .fontWeight(.medium)
                .foregroundColor(viewModel.enabled ? .white : .gray)
                .frame(maxWidth: .infinity, maxHeight: 44)
        }
        .disabled(!viewModel.enabled)
        .background(viewModel.enabled
                    ? themeManager.selectedTheme.primary.swiftUIColor
                    : .gray.opacity(0.3))
        .cornerRadius(8)
    }
}
