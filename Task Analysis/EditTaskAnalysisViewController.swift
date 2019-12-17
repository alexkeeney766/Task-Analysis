//
//  EditTaskAnalysisViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 8/25/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit
import CoreData

class EditTaskAnalysisViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var previousVC = MainViewController()
    var currentButton = UIButton()
    var selectedTaskAnalysis : TaskAnalysis?
    var stepCounter = 1
    
    @IBOutlet weak var titleTestField: UITextField!
    @IBOutlet weak var nextStepHighlightedToggle: UISwitch!
    @IBOutlet weak var skippedStepHighlightedToggle: UISwitch!
    @IBOutlet weak var scrollView: UIScrollView!
    var stepStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard let image = info[.originalImage] as? UIImage else { return }
        
        currentButton.setBackgroundImage(image, for: .normal)
        currentButton.setTitle("", for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
