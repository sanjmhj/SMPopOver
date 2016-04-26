import UIKit

class ViewController: UITableViewController {
    var data = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,    24,25,    26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,    44,45,    46,47,    48,49,    50,51,    52,53,    54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,    70,71,    72,73,    74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100 ]
    
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCellID") as? BasicCell
        guard let cell = tableView.dequeueReusableCellWithIdentifier("BasicCellID") as? BasicCell else { return UITableViewCell() }
        cell.label.text = String(self.data[indexPath.row])
        return cell
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
