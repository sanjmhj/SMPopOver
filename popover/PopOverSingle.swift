import UIKit

protocol PopOverSingleDelegate {
    func popOverCellSelected(index: Int)
    func popOverCellDisselected(index: Int)
}

class PopOverSingle: UIViewController {
    
    var options = ["item1","item2","item3"]
    var delegate: PopOverSingleDelegate?

    @IBOutlet var optionsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.optionsTV.tableFooterView = UIView()
    }
}

extension PopOverSingle: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.cellForRowAtIndexPath(indexPath)?.accessoryType == .Checkmark {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
            self.delegate?.popOverCellDisselected(indexPath.row)
        } else {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
            self.delegate?.popOverCellSelected(indexPath.row)
        }
    }
}

extension PopOverSingle: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("OptionsCell") as? OptionsCell else { return UITableViewCell() }
        cell.options.text = options[indexPath.row]
        return cell
    }
}

