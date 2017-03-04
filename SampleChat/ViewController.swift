import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController {

    @IBAction func didTouchPostButton(_ sender: UIButton) {
        print("didTap: \(textView.text)")
        textView.text = nil
        textView.resignFirstResponder()
    }
}
