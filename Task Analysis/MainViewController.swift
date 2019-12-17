//
//  ViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 7/4/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {
    
    // Properties and Variables
//    var appDelegate = UIApplication.shared.delegate as! AppDelegate
//    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var container: NSPersistentContainer!
    var taskAnalyses : [TaskAnalysis] = []
    var allSteps : [Step] = []
    var toBeDeleted : [TaskAnalysis] = []
    var deleteContext: NSManagedObjectContext!
    
    // View will/did functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = NSPersistentContainer(name: "Task_Analysis")
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }

        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        loadData()
    }
    
    
    
    // Custom Funcitons
    func saveContext() {
//        loadToDelete()
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                for task in taskAnalyses {
                    if task.name == "deleteMe" {
                        container.viewContext.delete(task)
                    }
                }
            } catch let error as NSError {
                print("An error occured while saving: \(error);;;;;;;;; -> \(error.userInfo)")
            }
        }
    }
    
    
    func loadData() {
        let request = TaskAnalysis.createFetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: false)
//        request.predicate = NSPredicate(format: "NOT name == deleteMe") // Research current NSPredicate 
        
        request.sortDescriptors = [sort]
        
        do {
            taskAnalyses = try container.viewContext.fetch(request)
            tableView.reloadData()
            for task in taskAnalyses {
                if task.name == "deleteMe" {
                    container.viewContext.delete(task)
                }
            }
        } catch let error as NSError {
            print("fetch failed with : \(error);;;;;;;;; -> \(error.userInfo)")
            
        }
        
        let request1 = Step.createFetchRequest()
        do {
            allSteps = try container.viewContext.fetch(request1)
            
        } catch let error as NSError {
            
            print("fetch failed with : \(error)")
        }
        
        
    }
    
    func loadToDelete() {
        let request = TaskAnalysis.createFetchRequest()
        request.predicate = NSPredicate(format: "name MATCHES deleteMe")
        do {
            toBeDeleted = try container.viewContext.fetch(request)
            for TA in toBeDeleted {
                print("deleted -> \(TA.name)")
                container.viewContext.delete(TA)
            }
        } catch let error as NSError {
            print( " tried to delete blank T.A.'s but couldn't due too: >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>      \(error)")
        }
    }
    
    // tableView Overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskAnalyses.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskAnalysis", for: indexPath)
        
        cell.textLabel?.text = taskAnalyses[indexPath.row].name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var taskAnalysis = TaskAnalysis(context: container.viewContext)
        taskAnalysis = taskAnalyses[indexPath.row]
        performSegue(withIdentifier: "Action", sender: taskAnalysis)
//        if let actionVC = storyboard?.instantiateViewController(withIdentifier: "Action") as? ActionViewController {
//            actionVC.selectedTaskAnalysis = taskAnalysis
//            actionVC.previousVC = self
//
//            let steps = taskAnalysis.steps.objectEnumerator()
//            for step in steps {
//                actionVC.taskSteps.append(step as! Step)
//            }
////            actionVC.skippedStepHighlighted = ta
//            navigationController?.pushViewController(actionVC, animated: true)
//        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddTaskAnalysisViewController {
            addVC.previousVC = self
        }
        
        if let actionVC = segue.destination as? ActionViewController {
            
            let indexPath = tableView.indexPathForSelectedRow!
            let taskAnalysis = taskAnalyses[indexPath.row]
//            actionVC.selectedTaskAnalysis = sender as? TaskAnalysis
            actionVC.previousVC = self
            actionVC.nextStepHighlighted = taskAnalysis.nextStepHighlighted
            actionVC.skippedStepHighlighted = taskAnalysis.skippedStepHighlighted
            if let steps = taskAnalysis.steps?.objectEnumerator() {
                for step in steps {
                    actionVC.taskSteps.append((step as! Step))
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskAnalyses[indexPath.row]
            
            if let steps = task.steps?.objectEnumerator() {
                for step in steps {
                    container.viewContext.delete(step as! Step)
                }
            }
            
            container.viewContext.delete(task)
            taskAnalyses.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            saveContext()
        }
    }
    
}
