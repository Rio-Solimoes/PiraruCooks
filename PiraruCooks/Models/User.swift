//
//  User.swift
//  PiraruCooks
//
//  Created by Guilherme Ferreira Lenzolari on 07/05/24.
//

import Foundation
import CloudKit

struct User: CKRecordValueProtocol {
    let id: UUID
    let name: String?
    let adress: String?
    
    init(id: UUID, name: String?, adress: String?) {
        self.id = id
        self.name = name
        self.adress = adress
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.adress = ""
    }
}
