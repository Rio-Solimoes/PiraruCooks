//
//  User.swift
//  PiraruCooks
//
//  Created by Guilherme Ferreira Lenzolari on 07/05/24.
//

import Foundation
import CloudKit

struct Account: CKRecordValueProtocol {
    let id: UUID
    let name: String?
    let adress: String?
    let email: String?
    let recordName: String?
    
    init(id: UUID, name: String?, adress: String?, phone: String?, recordName: String?) {
        self.id = id
        self.name = name
        self.adress = adress
        self.email = phone
        self.recordName = recordName
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.adress = ""
        self.email = ""
        self.recordName = ""
    }
}
