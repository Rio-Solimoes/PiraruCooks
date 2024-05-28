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
                .foregroundColor(viewModel.enabled ? .white : Shared.Colors.darkGray.swiftUIColor)
                .frame(maxWidth: .infinity, maxHeight: 44)
        }
        .disabled(!viewModel.enabled)
        .background(viewModel.enabled
                    ? themeManager.selectedTheme.primary.swiftUIColor
                    : Shared.Colors.mediumGray.swiftUIColor)
        .cornerRadius(8)
    }
}
