import SwiftUI
import CloudKit

@MainActor
final class CloudKitModel: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var permissionStatus: Bool = false    
    @Published var user: [Account] = []
    
    let container = CKContainer.init(identifier: "iCloud.pirarucooksapp")
    let database: CKDatabase
    
    init() {
        self.database = container.publicCloudDatabase
        getiCloudStatus()
        requestPermission()
        userLogin()
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
    
    // find userId
    func userLogin() {
        container.fetchUserRecordID { [weak self] returnedID, _ in
            DispatchQueue.main.async { [weak self] in
                if let id = returnedID {
                    Task {
                        let userInfo = await self!.getUserInfo(userRecordName: id.recordName)
                        print("ID: \(id.recordName)")
                        if userInfo == nil {
                            self?.addNewUser(id: id)
                        } else {
                            print("UserInfo: \(String(describing: userInfo))")
                        }
                    }
    
                }
            }
        }
    }
    
    // add userId and userName to database
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
    
    private func getUserInfo(userRecordName: String) async -> CKRecord? {
        let predicate = NSPredicate(format: "recordName == %@", userRecordName)
        let query = CKQuery(recordType: "Account", predicate: predicate)
        
        do {
            let resultRecords = try await database.records(matching: query)
            if !resultRecords.matchResults.isEmpty {
                return try resultRecords.matchResults.first?.1.get()
            } else {
                return nil
            }
        } catch {
            print("Preciso tratar o erro \(error)")
            return nil
        }
    }
    
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
