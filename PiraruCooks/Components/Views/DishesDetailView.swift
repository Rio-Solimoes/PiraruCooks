//
//  DishesDetailView.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 14/05/24.
//

import SwiftUI
import Parintins
import Combine

struct DishesDetailView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    @State var viewModel = DishesDetailViewModel()
    @Binding var isMenuDetailScrolling: Bool
    var selectedDish: MenuItem?
    var showCloseButton: Bool

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                if showCloseButton {
                    closeButton
                }
                dishImage
                dishInformation
                orderInformation
                addOrderButton
                
                Divider()
                
                customerRating
            }
            .onAppear {
                tabBarViewModel.isDishesDetailPresented = true
            }
            .padding()
            .padding(.bottom)
            .background(viewModel.scrollOffsetPreference)
            .onPreferenceChange(ViewOffsetKey.self, perform: handlePreferenceChange)
        }
        .modifier(BouncesModifier())
        .coordinateSpace(name: "scroll")
        .onChange(of: tabBarViewModel.isDishesDetailPresented) {
            if !tabBarViewModel.isDishesDetailPresented {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    // MARK: View Components
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getWidth() * 0.07, height: getHeight() * 0.02)
                    .foregroundColor(Shared.Colors.mediumGray.swiftUIColor)
            }
        }
        .padding(.trailing, -8)
    }
    
    private var dishImage: some View {
        ZStack {
            GeometryReader { geometry in
                if let image = selectedDish?.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: getHeight() * 0.4)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                } else {
                    Shared.Images.emptyDish.swiftUIImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: getHeight() * 0.4)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                }

                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .clear, location: 0.8),
                        .init(color: .white.opacity(0.4), location: 0.85),
                        .init(color: .white.opacity(0.6), location: 0.9),
                        .init(color: .white.opacity(0.8), location: 0.95),
                        .init(color: .white, location: 1)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: geometry.size.width, height: getHeight() * 0.4)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(height: getHeight() * 0.4)
        }
    }
    
    private var dishInformation: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                dishCategory
                Spacer()
                saveDishButton
            }
            .padding(.bottom, 8)
            
            Text(selectedDish?.name ?? "")
                .font(.title2)
                .fontWeight(.semibold)
            Text(selectedDish?.detailText ?? "")
            Text("R$ \(replaceDotWithComma(String(format: "%.2f", selectedDish?.price ?? 00.00)))")
                .padding(.top, 8)
        }
    }
    
    private var orderInformation: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Quantidade:")
                Spacer()
                Stepper(value: $viewModel.stepperValue, in: 0...Int.max) {
                    Text("\(viewModel.stepperValue)")
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Shared.Colors.mediumGray.swiftUIColor)
            )
            
            TextField("Observação", text: $viewModel.textFieldText) {
                UIApplication.shared.endEditing()
            }
                .padding()
                .padding(.bottom)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Shared.Colors.mediumGray.swiftUIColor)
                )
        }
    }

    private var addOrderButton: some View {
        Button {
            // Action
        } label: {
            Text("Adicionar | R$ \(formattedPrice)")
                .frame(maxWidth: .infinity)
                .padding()
                .fontWeight(.semibold)
                .foregroundStyle(buttonForegroundColor)
                .background(
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(buttonBackgroundColor)
                )
                .padding(.horizontal, 16)
        }
    }

    private var customerRating: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Avaliação dos Clientes")
                .font(.title2)
                .fontWeight(.semibold)
            
            placeholderCustomerReview
        }
    }
    
    // MARK: Helpers
    private var dishCategory: some View {
        Text(selectedDish?.category ?? "")
            .padding(6)
            .fontWeight(.semibold)
            .foregroundStyle(themeManager.selectedTheme.primary.swiftUIColor)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.clear, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(themeManager.selectedTheme.secondary.swiftUIColor)
                    )
            )
    }
    
    private var saveDishButton: some View {
        Button {
            viewModel.isSaved.toggle()
        } label: {
            Image(systemName: viewModel.isSaved ? "bookmark.circle.fill" : "bookmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getWidth() * 0.07, height: getHeight() * 0.02)
                .foregroundStyle(themeManager.selectedTheme.primary.swiftUIColor)
        }
    }
    
    private var formattedPrice: String {
        let price = (selectedDish?.price ?? 00.00) * Double(viewModel.stepperValue)
        return replaceDotWithComma(String(format: "%.2f", price))
    }

    private var buttonForegroundColor: Color {
        viewModel.stepperValue > 0 ? .white : Shared.Colors.darkGray.swiftUIColor
    }

    private var buttonBackgroundColor: Color {
        viewModel.stepperValue > 0
            ? themeManager.selectedTheme.primary.swiftUIColor
            : Shared.Colors.mediumGray.swiftUIColor
    }
    
    private var placeholderCustomerReview: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ótimo")
                .fontWeight(.semibold)
            Text("Amei esse prato principal!!")
            
            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: getWidth() * 0.04)
                        .foregroundStyle(Shared.Colors.darkGray.swiftUIColor)
                }
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Shared.Colors.lightGray.swiftUIColor)
        )
    }
    
    // Identifies the position on which the view is being scrolled
    func handlePreferenceChange(currentOffset: CGFloat) {
        let offsetDifference: CGFloat = viewModel.previousViewOffset - currentOffset
        if abs(offsetDifference) > viewModel.minimumOffset {
            if offsetDifference < 0 {
                isMenuDetailScrolling = true
            } else if offsetDifference > 25 {
                isMenuDetailScrolling = false
            }
            self.viewModel.previousViewOffset = currentOffset
        }
    }
}
