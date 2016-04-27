import UIKit

class PopOverImage: UIViewController {
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = self.image.frame.size //for specific size of the popOverController
    }

}
