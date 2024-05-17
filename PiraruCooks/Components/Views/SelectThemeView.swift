import SwiftUI
import Parintins

struct SelectThemeView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("O Festival de Parintins está chegando!")
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            Text("Escolha o seu boi favorito e aproveite o festival no seu estilo!")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.bottom, 28)
            HStack(spacing: 12) {
                Button {
                    themeManager.selectedTheme = Themes.Garantido.shared
                } label: {
                    VStack {
                        Themes.Garantido.shared.profileDefault.swiftUIImage
                        Text("Garantido")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                themeManager.selectedTheme.userDefaultsValue == "Garantido" ?
                                themeManager.selectedTheme.primary.swiftUIColor :
                                        .gray,
                                lineWidth: 2)
                    )
                }
                Button {
                    themeManager.selectedTheme = Themes.Caprichoso.shared
                } label: {
                    VStack {
                        Themes.Caprichoso.shared.profileDefault.swiftUIImage
                        Text("Caprichoso")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                themeManager.selectedTheme.userDefaultsValue == "Caprichoso" ?
                                themeManager.selectedTheme.primary.swiftUIColor :
                                        .gray,
                                lineWidth: 2)
                    )
                }
            }
                .padding(.bottom, 40)
            ButtonView(viewModel: ButtonViewModel(
                text: "Confirmar",
                action: { dismiss() },
                enabled: true)
            )
                .padding(.horizontal, 20)
        }
        .padding(20)
        .interactiveDismissDisabled()
    }
}

#Preview {
    SelectThemeView()
}
