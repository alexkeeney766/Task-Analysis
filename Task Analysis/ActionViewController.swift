//
//  ActionViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 7/19/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {
    
    lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentSize.height = 10000
        view.backgroundColor = .brown
        return view
    }()

    lazy var contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    
    var previousVC = MainViewController()
    var selectedTaskAnlaysis = TaskAnalysis()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        initializeScrollView()
        initializeContentlView()
        
        
//        placeLabels()
    }

    
//    func makeLabel(step : String) -> UILabel {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = step
//        label.textColor = .white
//        label.sizeToFit()
//
//        return label
//    }
    
    
//    func placeLabels() {
//        if selectedTaskAnlaysis.steps.count == 0 {
//            return
//        }
//        
//        var labels : [UILabel] = []
//
//        var previous : UILabel?
//
//        for i in 0..<selectedTaskAnlaysis.steps.count {
//            
//            labels.append(makeLabel(step: selectedTaskAnlaysis.steps[i]))
//
//            //embed in scrollview
//            contentView.addSubview(labels[i])
//
//            // Add constraints to labels
//            labels[i].leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
//            labels[i].trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
//
//            labels[i].heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
//
//            if let previous = previous {
//                labels[i].topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
//            } else {
//                labels[i].topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//            }
//
//            previous = labels[i]
//        }
//    }
    
    func initializeScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func initializeContentlView() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}


