import UIKit

protocol PopOverSingleDelegate {
    func popOverCellSelected(index: Int)
    func popOverCellDisselected(index: Int)
}

var data = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,  52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100 ]

enum Options: Int {
    case All, Odd, Even, Prime, Fibonacci, Other
    static func getCount() -> Int {
        return 4 //just to populate the first 3 cases
    }
    
    func getData() -> [Int] {
        var resultData = [Int]()
        switch self {
        case .All:
            resultData = data
        case .Odd:
            for number in data {
                if number % 2 == 1 {
                    resultData.append(number)
                }
            }
        case .Even:
            for number in data {
                if number % 2 == 0 {
                    resultData.append(number)
                }
            }
        default:
        resultData = data
        }
        return resultData
    }
    
    func getNameString() -> String {
        switch self {
        case .All:
            return "All"
        case .Odd:
            return "Odd"
        case .Even:
            return "Even"
        case .Prime:
            return "Prime"
        case .Fibonacci:
            return "Fibonacci"
        case .Other:
            return "Others"
        }
        
    }
    
    func getTitleString() -> String {
        return "\(getNameString()) \u{25BE}"
    }
    
}

class PopOverSingle: UIViewController {
    
    var delegate: PopOverSingleDelegate?
    var selectedOption: Options?

    @IBOutlet var optionsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.optionsTV.tableFooterView = UIView()// for blank plain view at black space at end of the table view
        self.preferredContentSize = self.optionsTV.contentSize //height of cell * number of options on list
    }
}

extension PopOverSingle: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //clearing all the checkmark in the table
        for rowNumber in 0 ..< Options.getCount() {
            if let cellToClear = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: rowNumber, inSection: 0)) {
                cellToClear.accessoryType = .None
            }
        }
        //putting the checkmark in the selected row
        let index = NSIndexPath(forRow: indexPath.row, inSection: 0)
        tableView.cellForRowAtIndexPath(index)?.accessoryType = .Checkmark
        
        self.selectedOption = Options(rawValue: indexPath.row)
        self.delegate?.popOverCellSelected(indexPath.row)
        
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
        //for checkmark at the initial state
        if indexPath.row == self.selectedOption!.rawValue {
            let index = NSIndexPath(forRow: (self.selectedOption?.rawValue)!, inSection: 0)
            cell.accessoryType = .Checkmark
        }
        return cell
    }
}
