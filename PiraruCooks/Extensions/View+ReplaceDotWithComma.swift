//
//  View+ReplaceDotWithComma.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 15/05/24.
//

import Foundation
import SwiftUI

extension View {
    func replaceDotWithComma(_ text: String) -> String {
        return text.replacingOccurrences(of: ".", with: ",")
    }
}
