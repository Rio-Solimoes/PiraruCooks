import SwiftUI
import Parintins

struct SelectThemeView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Os temas do Festival de Parintins já estão disponíveis")
                .fontWeight(.semibold)
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)
            Text("Escolha seu boi preferido e desfrute dos sabores amazônicos!")
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
            if themeManager.selectedTheme.userDefaultsValue == "Parintins" {
                ButtonView(viewModel: ButtonViewModel(
                    text: "Confirmar",
                    action: { dismiss() },
                    enabled: false)
                )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
            } else {
                ButtonView(viewModel: ButtonViewModel(
                    text: "Confirmar",
                    action: { dismiss() },
                    enabled: true)
                )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
            }
            if themeManager.selectedTheme.userDefaultsValue == "Parintins" {
                Button {
                    dismiss()
                } label: {
                    Text("Continuar usando tema padrão")
                        .padding(.horizontal, 20)
                }
            } else {
                Button {
                    themeManager.selectedTheme = Themes.Parintins.shared
                    dismiss()
                } label: {
                    Text("Voltar ao tema padrão")
                        .padding(.horizontal, 20)
                }
            }
        }
        .padding(20)
        .interactiveDismissDisabled()
    }
}

#Preview {
    SelectThemeView()
}
