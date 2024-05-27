//
//  String+Normalize.swift
//  PiraruCooks
//
//  Created by Larissa Fazolin on 21/05/24.
//

import SwiftUI

// Extension to remove diacritical marks (ex: "àgua" turns into "agua)
extension String {
    func normalized() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
