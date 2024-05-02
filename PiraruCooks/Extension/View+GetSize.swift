//
//  View+GetSize.swift
//  PiraruCooks
//
//  Created by Guilherme Ferreira Lenzolari on 29/04/24.
//

import Foundation
import SwiftUI

extension View {
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    func getHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
