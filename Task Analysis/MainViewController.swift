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
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var container: NSPersistentContainer!
//    var taskAnalyses : [TaskAnalysis] = []
    var taskAnalyses : [TaskAnalysisCoreData] = []

    
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
//        taskAnalyses = createTaskAnalyses()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        loadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        do {
//            taskAnalyses = try context.fetch(TaskAnalysisCoreData.fetchRequest()) as! [TaskAnalysisCoreData]
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
//
    
    
    
    // Custom Funcitons
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occured while saving: \(error)")
            }
        }
    }
    
    
    func loadData() {
        let request = TaskAnalysisCoreData.createFetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            taskAnalyses = try container.viewContext.fetch(request)
            tableView.reloadData()
        } catch let error as NSError {
            print("fetch failed with : \(error)")
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
        let taskAnalysis = taskAnalyses[indexPath.row]
        performSegue(withIdentifier: "Action", sender: taskAnalysis)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddTaskAnalysisViewController {
            addVC.previousVC = self
        }
        
        if let actionVC = segue.destination as? ActionTableViewController {
            
            if let taskAnalysis = sender as? TaskAnalysisCoreData {
                actionVC.selectedTaskAnlaysis = taskAnalysis
                actionVC.previousVC = self
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            container.viewContext.delete(taskAnalyses[indexPath.row])
            taskAnalyses.remove(at: indexPath.row)
//
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            saveContext()
        }
    }
    
    
    
    
    
    
    
    //    func getTaskAnalyses() {
    //        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
    //            if let coreDataTaskAnalyses = try? context.fetch(
    //        }
    //    }
    
//    func createTaskAnalyses() -> [TaskAnalysis] {
//        let firstTA = TaskAnalysis()
//        let secondTA = TaskAnalysis()
//        let thirdTA = TaskAnalysis()
//
//        firstTA.name = "Math Problems"
//        secondTA.name = "Reading Passages"
//        thirdTA.name = "Life Skills"
//
//        firstTA.nextStepHighlighted = true
//        secondTA.skippedStepHighlighted = true
//
//        return [firstTA, secondTA, thirdTA]
//    }
}

