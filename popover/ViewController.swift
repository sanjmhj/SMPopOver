import UIKit

class ViewController: UITableViewController {
    var tableData = [Int]()
    var titleView: UIView?
    var navTitle: UILabel?
    var popoverViewController: PopOverSingle!
    var popoverImageController: PopOverImage!
    var width: CGFloat?
    var height: CGFloat?

    var selectedOption = Options.All
    override func viewDidLoad() {
        super.viewDidLoad()
        //populating the data at initial state
        self.tableData = self.selectedOption.getData()
        
        self.width = (self.navigationController?.navigationBar.frame.width)!
        self.height = (self.navigationController?.navigationBar.frame.height)!
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.popOverController(_:)))
        titleView = UIView(frame: CGRect(origin: CGPoint(x: width! / 2, y: height! / 2), size: CGSize(width: width! / 2, height: height!)))
        navTitle = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width! / 2 , height: height!)))
        navTitle?.textAlignment = .Center
        navTitle?.text = self.selectedOption.getTitleString()
        titleView?.addSubview(navTitle!)
        titleView!.addGestureRecognizer(tap)
        self.navigationItem.titleView = titleView
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PopSegueID" {
            popoverViewController = segue.destinationViewController as! PopOverSingle
            popoverViewController.selectedOption = self.selectedOption
            popoverViewController.delegate = self
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.popoverPresentationController?.sourceView = self.navigationController?.navigationBar.topItem?.titleView
            popoverViewController.popoverPresentationController?.sourceRect = CGRect(x: self.titleView!.frame.width / 2, y: 0, width: 0, height: height!)
            popoverViewController.popoverPresentationController?.permittedArrowDirections = .Up
        } else if segue.identifier == "PopImageSegueID" {
            popoverImageController = segue.destinationViewController as! PopOverImage
            popoverImageController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverImageController.popoverPresentationController!.delegate = self
            popoverImageController.popoverPresentationController?.sourceView = self.navigationController?.navigationBar.topItem?.titleView
            popoverImageController.popoverPresentationController?.sourceRect = CGRect(x: self.titleView!.frame.width / 2, y: 0, width: 0, height: height!)
            popoverImageController.popoverPresentationController?.permittedArrowDirections = .Up
        }
    }
    
    func popOverController(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("PopImageSegueID", sender: self)
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
        return self.tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("BasicCellID") as? BasicCell else { return UITableViewCell() }
        cell.label.text = "\(self.tableData[indexPath.row])"
        return cell
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    
}

extension ViewController: PopOverSingleDelegate {
    func popOverCellSelected(index: Int) {
        self.selectedOption = Options(rawValue: index)!
        self.tableData = self.selectedOption.getData()
        self.navTitle!.text = self.selectedOption.getTitleString()
        self.tableView.reloadData()
    }
    
    func popOverCellDisselected(index: Int) {
        print("Dis ---- Selected   \(index)")
    }
}
