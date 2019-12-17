//
//  AddTaskAnalysisViewController1.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 8/13/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit
import CoreData



class AddTaskAnalysisViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var previousVC = MainViewController()
    var stepCounter: Int = 1
    var currentButtonIdx : Int = 0
    var currentImage = UIImage()
    var stepImages = [Data](repeating: Data(), count: 15)
    var currentButton = UIButton()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nextStepHighlightedToggle: UISwitch!
    @IBOutlet weak var skippedStepsHighlightedToggle: UISwitch!
    var stepStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepImages.reserveCapacity(15)
        
        // Creating initial layout
        stepStackView.axis = .vertical
        stepStackView.alignment = .fill
        stepStackView.spacing = 10
        stepStackView.distribution = .fill
        scrollView.addSubview(stepStackView)
        
        // Adding Constraints
        stepStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stepStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stepStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stepStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // Prohibiting horizontal scrolling
            stepStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        addStep()
    }
    
    
    @IBAction func addStepTapped(_ sender: Any) {
        addStep()
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        var taskAnalysis : TaskAnalysis
        if let taskTitle = titleTextField.text {
            if taskTitle != "" {
                taskAnalysis = newTask(title: taskTitle, nextStep: nextStepHighlightedToggle.isOn, skippedStep: skippedStepsHighlightedToggle.isOn)
                for cell in stepStackView.subviews {
                    
                    let stepTextField = (cell.subviews[2] as? UITextField)
                    let stepButton = (cell.subviews[1] as? UIButton)
                    if let text = stepTextField?.text {
                        if let pic = stepButton?.backgroundImage(for: .normal) {
                            taskAnalysis.addToSteps(newStep(task: taskAnalysis, text: text, pic: pic))
                        } else {

                            taskAnalysis.addToSteps(newStep(task: taskAnalysis, text: text, pic: UIImage()))
                        }
                    } else {
                        taskAnalysis.addToSteps(newStep(task: taskAnalysis, text: "Empty Step", pic: UIImage()))
                    }
                }
            } else {
                let ac = UIAlertController(title: "Please Enter a Title",
                message: "Titles are required for the application to function correctly. ", preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                present(ac, animated: true)
                return
            }
        }
        
        previousVC.saveContext()
        previousVC.loadData()
        previousVC.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    
    // Helper Functions
    func addStep() {
        
        // Create View
        let cell = UIStackView()
        cell.axis = NSLayoutConstraint.Axis.horizontal
        cell.alignment = UIStackView.Alignment.center
        cell.distribution = UIStackView.Distribution.fillProportionally
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cell.spacing = 20
        
        // Create Subviews : Label
        let label = UILabel()
        label.text = "Step \(stepCounter)"
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.textAlignment = .center
        
        //      : Button for image
        let button = UIButton(type: .system)
        button.tag = stepCounter
        button.setTitle("Import Photo", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(importPicture), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
        //      : text Field
        let stepTextField = UITextField()
        stepTextField.placeholder = "Enter Step Here"
        stepTextField.borderStyle = .roundedRect
        stepTextField.autocorrectionType = .yes
        stepTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 480).isActive = true

        // Add subviews
        cell.addArrangedSubview(label)
        cell.addArrangedSubview(button)
        cell.addArrangedSubview(stepTextField)
        
        stepStackView.addArrangedSubview(cell)
        
        stepCounter += 1

    }
    
    @objc func importPicture(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        currentButton = sender
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        print(image.imageOrientation.rawValue)
        
        stepImages[currentButtonIdx] = image.pngData() ?? Data()
        
        currentButton.setBackgroundImage(image, for: .normal)
        currentButton.setTitle("", for: .normal)
        dismiss(animated: true, completion: nil)
    }

    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func newTask(title: String, nextStep: Bool, skippedStep: Bool) -> TaskAnalysis{
        let taskAnalysis = TaskAnalysis(context: previousVC.container.viewContext)
        taskAnalysis.name = title
        taskAnalysis.nextStepHighlighted = nextStep
        taskAnalysis.skippedStepHighlighted = skippedStep
        return taskAnalysis
    }
    
    func newStep(task: TaskAnalysis, text: String, pic: UIImage) -> Step {
        let step = Step(context: previousVC.container.viewContext)
        step.title = text
        if let data = pic.pngData() as NSData? {
            step.image = data
        }
        step.finished = false
        step.task = task
        return step
    }
}
