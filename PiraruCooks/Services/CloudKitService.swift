import SwiftUI
import CloudKit

@MainActor
final class CloudKitModel: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    @Published var permissionStatus: Bool = false
    var userRecordName = ""
    
    @Published var user: [Account] = []
    
    let container = CKContainer.init(identifier: "iCloud.pirarucooksapp")
    let database: CKDatabase
    
    init() {
        self.database = container.publicCloudDatabase
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordNameAndSaveOnDatabase()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, _  in
            print("status: \(returnedStatus)")
            
            DispatchQueue.main.async { [weak self] in
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    func requestPermission() {
        self.container.requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, _ in
            DispatchQueue.main.async {[weak self] in
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                    print("permissionStatus: \(String(describing: self?.permissionStatus.description))")
                }
            }
        }
    }
    
    //find userId
    func fetchiCloudUserRecordNameAndSaveOnDatabase() {
        container.fetchUserRecordID { [weak self] returnedID, _ in
            DispatchQueue.main.async { [weak self] in
                if let id = returnedID {
                    self?.addNewUser(id: id)
                }
            }
        }
    }
    
    //add userId and userName to database
    private func addNewUser(id: CKRecord.ID) {
        let newUserRecordName = CKRecord(recordType: "Account")
        newUserRecordName["recordName"] = id.recordName
        saveItem(record: newUserRecordName)
        
        self.container.fetchShareParticipant(withUserRecordID: id) { [weak self] returnIdentity, _ in
            DispatchQueue.main.async { [weak self] in
                if let name = returnIdentity?.userIdentity.nameComponents?.givenName,
                   let familyName = returnIdentity?.userIdentity.nameComponents?.familyName {
                    let userName = "\(name) \(familyName)"
                    newUserRecordName["name"] = userName
                    self!.saveItem(record: newUserRecordName)
                }
            }
        }
    }
    
//        private func userIsOnDatabase(userRecordName: String) async -> CKRecord? {
//            let predicate = NSPredicate(format: "recordName == %@", userRecordName)
//            let query = CKQuery(recordType: "Account", predicate: predicate)
//    
//            do {
//                let result = try await database.records(matching: query)
//                result.matchResults
//            } catch {
//    
//            }
//        }
    
    func saveItem(record: CKRecord) {
        database.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
        }
    }
}

enum CloudKitError: String, LocalizedError {
    case iCloudAccountNotFound
    case iCloudAccountNotDetermined
    case iCloudAccountRestricted
    case iCloudAccountUnknown
}
