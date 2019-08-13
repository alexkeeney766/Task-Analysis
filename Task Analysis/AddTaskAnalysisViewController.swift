//
//  AddTaskAnalysisViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 7/9/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit

class AddTaskAnalysisViewController: UIViewController {
    
    // Create Variables
    var previousVC = MainViewController()

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nextStepHighlightedSwitch: UISwitch!
    @IBOutlet weak var skippedStepsHighlightedSwitch: UISwitch!
    // Detect when one step has been added and add a new textField.
    @IBOutlet weak var Step1TextField: UITextField!
    @IBOutlet weak var Step2TextField: UITextField!
    @IBOutlet weak var step3TextField: UITextField!
    @IBOutlet weak var step4TextField: UITextField!
    @IBOutlet weak var step5TextField: UITextField!
    @IBOutlet weak var step6TextField: UITextField!
    
    
    
    // Meathods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Buttons and Actions
    @IBAction func addTapped1(_ sender: Any) {
        
        let taskAnalysis = TaskAnalysisCoreData(context: previousVC.container.viewContext)
        
        if let taskTitle = titleTextField.text {
            if taskTitle != ""{
                taskAnalysis.name = taskTitle
            } else {
//                let ac = UIAlertController(title: "Please Enter a Title", message: "Titles are required for the application to function correctly. ", preferredStyle: .actionSheet)
//                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//                present(ac, animated: true)
//                print("ac ran")
//                return
            }
            
        }
        
        for stepsTextField in [Step1TextField, Step2TextField, step3TextField, step4TextField, step5TextField, step6TextField]   {
            if let taskSteps = stepsTextField?.text {
                taskAnalysis.steps.append(taskSteps)
                previousVC.saveContext()
                previousVC.loadData()
            }
        }
        
        taskAnalysis.nextStepHighlighted = nextStepHighlightedSwitch.isOn
        taskAnalysis.skippedStepHighlighted = skippedStepsHighlightedSwitch.isOn
        previousVC.tableView.reloadData()
        navigationController?.popViewController(animated: true)
        
    }

}
