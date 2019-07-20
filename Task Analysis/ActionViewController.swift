//
//  ActionViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 7/19/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {
    
    var previousVC = MainViewController()
    var selectedTaskAnlaysis = TaskAnalysis()
    
    lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        view.backgroundColor = .blue
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        initializeScrollView()
//        placeLabels()
    }
    
    
    
    func initializeScrollView() {
//        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    
    func placeLabels() {
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        let label6 = UILabel()

        let labels = [label1, label2, label3, label4, label5, label6]


        var previous : UILabel?

        for i in 0...labels.count {

            labels[i].text = selectedTaskAnlaysis.steps[i]
            labels[i].sizeToFit()

            //embed in scrollview
            scrollView.addSubview(labels[i])

            // Add constraints to labels
            labels[i].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            labels[i].trailingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true

            labels[i].heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true

            if let previous = previous {
                labels[i].topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                labels[i].topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 10)
            }

            previous = labels[i]
        }
    }
    
}






//{
//
//    var previousVC = MainViewController()
//    var selectedTaskAnlaysis = TaskAnalysis()
//
//    let scrollView = UIScrollView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(scrollView)
//        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
//        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//
//        let label1 = UILabel()
//        let label2 = UILabel()
//        let label3 = UILabel()
//        let label4 = UILabel()
//        let label5 = UILabel()
//        let label6 = UILabel()
//
//        let labels = [label1, label2, label3, label4, label5, label6]
//
//
//        var previous : UILabel?
//
//        for i in 0...labels.count {
//
//            labels[i].text = previousVC.taskAnalyses[i].name
//            labels[i].sizeToFit()
//
//            //embed in scrollview
//            scrollView.addSubview(labels[i])
//
//            // Add constraints to labels
//            labels[i].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//            labels[i].trailingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//
//            labels[i].heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
//
//            if let previous = previous {
//                labels[i].topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
//            } else {
//                labels[i].topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 10)
//            }
//
//            previous = labels[i]
//        }
//
//
//    }
//
//
//}
