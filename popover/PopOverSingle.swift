import UIKit

protocol PopOverSingleDelegate {
    func popOverCellSelected(index: Int)
    func popOverCellDisselected(index: Int)
}
enum Options: Int {
    case Odd, Even, Prime, Fibonacci
    
    static func getCount() -> Int {
        return 4
    }
    
    func getNameString() -> String {
        switch self {
        case .Odd:
            return "Odd"
        case .Even:
            return "Even"
        case .Prime:
            return "Prime"
        case .Fibonacci:
            return "Fibonacci"
        }
    }
    
}

class PopOverSingle: UIViewController {
    
    var delegate: PopOverSingleDelegate?

    @IBOutlet var optionsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 0, height: 44 * Options.getCount()) //height of cell * number of options on list

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
        return Options.getCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("OptionsCell") as? OptionsCell else { return UITableViewCell() }
        cell.options.text = Options(rawValue: indexPath.row)?.getNameString()
        return cell
    }
}

