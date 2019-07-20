//
//  ViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 7/4/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var taskAnalyses : [TaskAnalysis] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskAnalyses = createTaskAnalyses()
        
        
    }
    
    func createTaskAnalyses() -> [TaskAnalysis] {
        let firstTA = TaskAnalysis()
        let secondTA = TaskAnalysis()
        let thirdTA = TaskAnalysis()
        
        firstTA.name = "Math Problems"
        secondTA.name = "Reading Passages"
        thirdTA.name = "Life Skills"
        
        firstTA.nextStepHighlighted = true
        secondTA.skippedStepHighlighted = true
        
        return [firstTA, secondTA, thirdTA]
    }
    
//    func getTaskAnalyses() {
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//            if let coreDataTaskAnalyses = try? context.fetch(
//        }
//    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskAnalyses.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskAnalysis", for: indexPath)
        
        cell.textLabel?.text = taskAnalyses[indexPath.row].name
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskAnalysis = taskAnalyses[indexPath.row]
        performSegue(withIdentifier: "Action", sender: taskAnalysis)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddTaskAnalysisViewController {
            addVC.previousVC = self
        }
        
        if let actionVC = segue.destination as? ActionViewController {
            
            if let taskAnalysis = sender as? TaskAnalysis {
                actionVC.selectedTaskAnlaysis = taskAnalysis
                actionVC.previousVC = self
            }
        }
    }
}

