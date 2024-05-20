//
//  View+EndKeyboardEditing.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 15/05/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
