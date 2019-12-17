//
//  ActionViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 8/17/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

public extension UIView {
    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}


class ActionViewController: UIViewController {
    
    // Initial Variables
    var stepCounter: Int = 0
    var previousVC = MainViewController()
//    weak var selectedTaskAnalysis : TaskAnalysis?
    var taskSteps :[Step] = []
    var skippedStepHighlighted = false
    var nextStepHighlighted = false
    var skippedStepsPresent = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    var stepStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepStackView.axis = .vertical
        stepStackView.alignment = .fill
        stepStackView.spacing = 10
        stepStackView.distribution = .fill
        scrollView.addSubview(stepStackView)
        
        stepStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stepStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stepStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stepStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // Prohibiting horizontal scrolling
            stepStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        
//        if let taskAnalysis = selectedTaskAnalysis {
//            skippedStepHighlighted = taskAnalysis.skippedStepHighlighted
//            nextStepHighlighted = taskAnalysis.nextStepHighlighted
//        }
        
        for taskStep in taskSteps {
            stepStackView.addArrangedSubview(makeCell(taskStep: taskStep))
        }
        
    }
    
    func makeCell(taskStep: Step) -> UIStackView {
        
        // Create View
        let cell = UIStackView()
        cell.axis = NSLayoutConstraint.Axis.horizontal
        cell.alignment = UIStackView.Alignment.center
        cell.distribution = UIStackView.Distribution.fillProportionally
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cell.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        cell.spacing = 20
        
        
        // Create Subviews: Speech button
        let speechButton = UIButton(type: .system)
        speechButton.tag = stepCounter
        speechButton.setTitle("Read", for: .normal)
        speechButton.setTitleColor(.blue, for: .normal)
        speechButton.addTarget(self, action: #selector(speakTask), for: .touchUpInside)
        speechButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        speechButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        //      : Image
        let pic = UIImageView()
//        var img : UIImage
        if let data = taskStep.image as Data? {
            if let img = UIImage(data: data) {
                if (img.imageOrientation == .up) {
                    pic.image = img
                } else {
                    UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
                    let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
                    img.draw(in: rect)
                    
                    let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    pic.image = normalizedImage
                    
                }
                print(img.imageOrientation.rawValue)
                print(pic.image?.imageOrientation.rawValue ?? "none")
            }
        }
        
//        pic.image = UIImage(data: taskStep.image as Data)
        pic.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pic.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //      : Text
        let label = UILabel()
        label.text = taskStep.title
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
//        label.widthAnchor.constraint(lessThanOrEqualToConstant: 400)
//        label.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
//        label.heightAnchor.constraint(lessThanOrEqualToConstant: 150)
        
        //      : Complete BUtton
        let button = UIButton(type: .system)
        button.tag = stepCounter
        button.setTitle("Complete", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pinBackGround(to: cell)
        taskStep.finished = false
        cell.addArrangedSubview(speechButton)
        cell.addArrangedSubview(pic)
        cell.addArrangedSubview(label)
        cell.addArrangedSubview(button)
        
        stepCounter += 1
        return cell
        
    }
 
    
    @objc func speakTask(sender: UIButton) {
        let idx = sender.tag
        let currentCell = stepStackView.arrangedSubviews[idx] as! UIStackView
        
        if let text = (currentCell.arrangedSubviews[2] as! UILabel).text {
            let utterance = AVSpeechUtterance(string: text)
            let avSpeechSynthesizer = AVSpeechSynthesizer()
            avSpeechSynthesizer.speak(utterance)
        }
    }
    
    

    @objc func completeTapped(sender: UIButton) {
        let idx = sender.tag
        let currentCell = stepStackView.arrangedSubviews[idx] as! UIStackView
        if taskSteps[idx].finished == false {
            taskSteps[idx].finished = true
            
            sender.setTitle("✅", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            if currentCell.subviews[0].backgroundColor == .red && skippedStepHighlighted {
                skippedStepsPresent -= 1
            }
            currentCell.subviews[0].backgroundColor = .none
        }
            
        else if taskSteps[idx].finished == true {
            taskSteps[idx].finished = false
            sender.setTitleColor(.blue, for: .normal)
            sender.setTitle("Complete", for: .normal)
        }
        
        if skippedStepHighlighted == true {
            for i in 0...taskSteps.count {
                if i == idx {
//                    if taskSteps[i].finished == false {
//                        skippedStepsPresent -= 1
//                    }
                    break
                } else if !(taskSteps[i].finished) {
                    stepStackView.arrangedSubviews[i].subviews[0].backgroundColor = .red
                    skippedStepsPresent += 1
                }
            }
        }
        
        if nextStepHighlighted == true {
            if skippedStepsPresent == 0 {
                if idx == taskSteps.count {
                    return
                }
                else if idx < taskSteps.count - 1 {
                    for i in idx..<taskSteps.count - 1 {
                        if taskSteps[i + 1].finished{
                            continue
                        } else {
                            stepStackView.arrangedSubviews[i + 1].subviews[0].backgroundColor = .green
                            break
                        }
                    }
                }
            }
        }
    }
    
    private func pinBackGround(to stackView: UIStackView) {
        let backgroundView : UIView = {
            let view = UIView()
            view.layer.cornerRadius = 20
            return view
        } ()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(backgroundView, at: 0)
        backgroundView.pin(to: stackView)
    }
}
