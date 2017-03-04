import Foundation
import SwiftActor

class MessagePost: Actor {
    
    override func receive(_ message: Any) {
        if let message = message as? String {
            MessageRepositoryInOnMemory.shared.post(message: message)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didPostMessage"), object: nil)  
        } else {
            print("not string.")
        }
    }
}

class Foo: Actor {
}

class Bar: Actor {
}

