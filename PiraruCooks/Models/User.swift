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
    let userPhoto: CKAsset?
    
    init(id: UUID, name: String?, adress: String?, userPhoto: CKAsset?) {
        self.id = id
        self.name = name
        self.adress = adress
        self.userPhoto = userPhoto
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.adress = ""
        self.userPhoto = nil
    }
}
