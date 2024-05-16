//
//  NoNetworkView.swift
//  PiraruCooks
//
//  Created by Guilherme Ferreira Lenzolari on 13/05/24.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        VStack {
            Text("Sem Conexão à Internet")
                .font(.title2)
                .fontWeight(.bold)
            
            // swiftlint:disable:next line_length
            Text("O iPhone não está conectado à internet.\nPara conectá-lo, desative o Modo Avião ou conecte-se a uma rede Wi-Fi.")
                .font(.footnote)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
            
            Button("Ir para Ajustes") {
                if let url = URL(string: "App-Prefs:root=WIFI") {
                  if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                      UIApplication.shared.openURL(url)
                    }
                  }
                }
            }.padding()
            
        }.padding()
    }
}

#Preview {
    NoNetworkView()
}
