import UIKit

class FirstVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTap(sender: UIButton) {
       self.performSegueWithIdentifier("segueId", sender: nil)
    }

}
