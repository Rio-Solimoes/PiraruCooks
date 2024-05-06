import SwiftUI
import CloudKit
import Combine

@MainActor
final class CloudKitModel: ObservableObject {

    // @Published var itens: [Item] = []
    let container = CKContainer.init(identifier: "iCloud.pirarucooks")
    let database: CKDatabase
    
    init() {
        self.database = container.publicCloudDatabase
    }
}
