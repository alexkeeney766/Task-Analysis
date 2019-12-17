//
//  ActionTableViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 7/21/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit


class stepCell : UITableViewCell {
    @IBOutlet weak var stepImage: UIImageView!
    @IBOutlet weak var stepTitle: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    
}

class greenStepCell : stepCell {
//    init() {
//        super.init()
//        backgroundColor = .green
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

class redStepCell : stepCell {
//    init() {
//        backgroundColor = .red
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

class blankStepCell : stepCell {
//    init() {
//        backgroundColor = .none
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

//struct step {
//    var title : String
//    var finished = false
//    var color = 0 // 0 is none, 1 is green, 2 is red
//    init(title: String) {
//        self.title = title
//    }
//}

class ActionTableViewController: UITableViewController {
    var skippedFlag = false
    
    var previousVC = MainViewController()
    var selectedTaskAnlaysis = TaskAnalysisCoreData()
    var taskSteps = [step]()
    

    // Main
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    // Function Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTaskAnlaysis.steps.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "step", for: indexPath) as! stepCell
        let step = taskSteps[indexPath.row]
//        if step.finished == true {
//            cell = tableView.dequeueReusableCell(withIdentifier: "finishedStep", for: indexPath) as! blankStepCell
//            cell.accessoryType = .checkmark
//            cell.backgroundColor = .none
//        } else {
//            if step.color == 1 {
//                cell = tableView.dequeueReusableCell(withIdentifier: "greenStep", for: indexPath) as! greenStepCell
//                cell.backgroundColor = .green
//                cell.accessoryType = .none
//            }
//            else {
//                cell = tableView.dequeueReusableCell(withIdentifier: "redStep", for: indexPath) as! redStepCell
//                cell.backgroundColor = .red
//                cell.accessoryType = .none
//            }
//        }
        
        cell.stepTitle?.text = step.title
        if step.finished == true {
            cell.accessoryType = .checkmark
            cell.backgroundColor = .none
        } else {
            cell.accessoryType = .none
            if step.color == 1 {
                cell.backgroundColor = .green
            } else  if step.color == 2 {
                cell.backgroundColor = .red
            }
        }

        cell.selectionStyle = .none
        return cell as stepCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! stepCell
        var step = taskSteps[indexPath.row]
        
        if step.finished == false {
//            cell.accessoryType = .checkmark
            step.finished = true
        } else {
//            cell.accessoryType = .none
            step.finished = false
        }
        
        // implementing Highlighting options
//        if selectedTaskAnlaysis.skippedStepHighlighted == true {
//            manageSkippedStepHighlighting(idx: indexPath)
//        }
        
        if selectedTaskAnlaysis.nextStepHighlighted == true {
            manageNextStepHighlighting(idx: indexPath)
        }
        
        
    }
    
    func manageSkippedStepHighlighting(idx: IndexPath) {
        var step = taskSteps[idx.row]
        
//        for cell in self.tableView.visibleCells as! [stepCell] {
//            if cell == self.tableView.cellForRow(at: idx) {
//                // reached tapped cell
//                break
//            }
//
//            else if !step.finished {
//                step.color = 2
//                cell.backgroundColor = .red
//
//            }
//        }
        
        for i in 0...taskSteps.count {
            if i == idx.row {
                break
            }
            
            else if !taskSteps[i].finished {
                step.color = 2
//                self.tableView.cellForRow(at: <#T##IndexPath#>)
            }
        }
    }
    
    
    func manageNextStepHighlighting(idx: IndexPath) {
        let nextIndexPath = IndexPath(row: idx.row+1, section: idx.section)
        let currentCell = tableView.cellForRow(at: idx) as! stepCell
        var step = taskSteps[idx.row]

        currentCell.backgroundColor = .none
        
        if idx.row == selectedTaskAnlaysis.steps.count {
            return
        }
            
        else if idx.row < selectedTaskAnlaysis.steps.count {
            if let nextCell = tableView.cellForRow(at: nextIndexPath) as? stepCell {
                if !taskSteps[idx.row + 1].finished {
                    nextCell.backgroundColor = .green
                    step.color = 1
                }
            }
        }
    }
    
    func skippedStep() -> Bool {
        var unfinishedFound = false
        
        for step in taskSteps {
            if unfinishedFound == false {
                if step.finished == true {
                    continue
                } else {
                    unfinishedFound = true
                }
            } else {
                if step.finished == true {
                    return true
                } else {
                    continue
                }
            }
        }
        return false
    }
}
