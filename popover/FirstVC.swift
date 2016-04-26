import UIKit

class FirstVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.items = []
    }

    @IBAction func buttonTap(sender: UIButton) {
       self.performSegueWithIdentifier("segueId", sender: nil)
    }

}
