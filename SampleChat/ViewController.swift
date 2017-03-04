import UIKit
import SwiftActor

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var textView: UITextView!

    fileprivate let system = ActorSystem(name: "chat")
    
    fileprivate var messages: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(self, selector: Selector("didPostMessage"), name: Notification.Name(rawValue: "didPostMessage"), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "didPostMessage"), object: nil)
    }
}

extension ViewController {

    func didPostMessage() {
        messages = messages + MessageRepositoryInOnMemory.shared.getAll()
        tableView.reloadData()
    }
}

extension ViewController {

    @IBAction func didTouchPostButton(_ sender: UIButton) {
        let messagePost = system.actorOf(MessagePost.self, name: "messagePost")
        messagePost.tell(textView.text)
        
        textView.text = nil
        textView.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
}
