import Foundation

class MessageRepositoryInOnMemory {
    static let shared = MessageRepositoryInOnMemory()

    private var messages: [String] = []

    private init() {}

    func getAll() -> [String] {
        return messages
    }

    func post(message: String) {
        messages.append(message)
    }
}
