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
    
    @IBOutlet weak var Step1TextField: UITextField!
    @IBOutlet weak var Step2TextField: UITextField!
    @IBOutlet weak var step3TextField: UITextField!
    @IBOutlet weak var step4TextField: UITextField!
    @IBOutlet weak var step5TextField: UITextField!
    @IBOutlet weak var step6TextField: UITextField!
    
    
    
    // Meathods
    override func viewDidLoad() {
        super.viewDidLoad()

//        title = "New Task Analysis"
    }
    
    // Buttons and Actions
    @IBAction func addTapped1(_ sender: Any) {
        
        let taskAnalysis = TaskAnalysis()
        
        if let taskTitle = titleTextField.text{
            taskAnalysis.name = taskTitle

        }
        
        
        
        for stepsTextField in [Step1TextField, Step2TextField, step3TextField, step4TextField, step5TextField, step6TextField]   {
            if let taskSteps = stepsTextField?.text {
                taskAnalysis.steps.append(taskSteps)
            }
                
        }

        
        
        
        taskAnalysis.nextStepHighlighted = nextStepHighlightedSwitch.isOn
        taskAnalysis.skippedStepHighlighted = skippedStepsHighlightedSwitch.isOn
        
        previousVC.taskAnalyses.append(taskAnalysis)
        previousVC.tableView.reloadData()
        navigationController?.popViewController(animated: true)
        
    }
    


}
