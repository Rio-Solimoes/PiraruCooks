import Foundation

@Observable
class ButtonViewModel {
    var text: String
    var action: () -> Void
    var enabled: Bool
    
    init(text: String, action: @escaping () -> Void, enabled: Bool = true) {
        self.text = text
        self.action = action
        self.enabled = enabled
    }
}
