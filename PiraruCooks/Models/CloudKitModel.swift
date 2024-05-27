import SwiftUI
import CloudKit

@MainActor
final class CloudKitModel: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    @Published var permissionStatus: Bool = false
    
    @Published var user: [User] = []
    
    let container = CKContainer.init(identifier: "iCloud.pirarucooks")
    let database: CKDatabase
    
    init() {
        self.database = container.publicCloudDatabase
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        
        CKContainer.default().accountStatus { [weak self] returnedStatus, _  in
  
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
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }

    func requestPermission() {
        self.container.requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, _ in
            DispatchQueue.main.async {[weak self] in
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                    //print("permissionStatus: \(String(describing: self?.permissionStatus.description))")
                }
            }
        }
    }
    
    func fetchiCloudUserRecordID() {
        container.fetchUserRecordID { [weak self] returnedID, _ in
            DispatchQueue.main.async { [weak self] in
                if let id = returnedID {
                    self?.discoveredCloudUser(id: id)
                }
            }
        }
    }
    
    func discoveredCloudUser(id: CKRecord.ID) {
        self.container.fetchShareParticipant(withUserRecordID: id) { [weak self] returnIdentity, _ in
            DispatchQueue.main.async { [weak self] in
                if let name = returnIdentity?.userIdentity.nameComponents?.givenName {
                    self?.userName = name
                    //print("name: \(String(describing: self?.userName))")

                }
            }
        }
    }
    
}
