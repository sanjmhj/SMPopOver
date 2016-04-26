import UIKit

class ViewController: UITableViewController {
    
    var options = ["1","2","3"]
    var titleView: UIView?
    var popoverViewController: PopOverSingle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var width = (self.navigationController?.navigationBar.frame.width)!
        var height = (self.navigationController?.navigationBar.frame.height)!
        let tap = UITapGestureRecognizer(target: self, action: Selector("popOverController:"))
        titleView = UIView(frame: CGRect(origin: CGPoint(x: width / 2, y: height / 2), size: CGSize(width: width/2, height: height)))
        var navTitle = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width/2 , height: height)))
        navTitle.textAlignment = .Center
        //u{25BE} unicode for down arrow
        navTitle.text = "The text to show  \u{25BE}"
        titleView?.addSubview(navTitle)
        titleView!.addGestureRecognizer(tap)
        self.navigationItem.titleView = titleView
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PopSegueID" {
            popoverViewController = segue.destinationViewController as! PopOverSingle
            popoverViewController.delegate = self
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.popoverPresentationController?.sourceView = self.navigationController?.navigationBar.topItem?.titleView
            popoverViewController.popoverPresentationController?.sourceRect = CGRect(x: self.titleView!.frame.width / 2, y: 0, width: 0, height: (self.navigationController?.navigationBar.frame.height)!)
            popoverViewController.popoverPresentationController?.permittedArrowDirections = .Up
            popoverViewController.preferredContentSize = CGSize(width: 0, height: 44 * options.count) //height of cell * number of options on list
        }
    }
    
    func popOverController(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("PopSegueID", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .None
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    
}

extension ViewController: PopOverSingleDelegate {
    func popOverCellSelected(index: Int) {
        //TODO : action when cell is selected
        print("Selected\(index)")
    }
    
    func popOverCellDisselected(index: Int) {
        print("Selected\(index)")
        //TODO : action when cell is selected
    }
}
