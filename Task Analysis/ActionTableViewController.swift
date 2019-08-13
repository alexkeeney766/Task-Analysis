//
//  ActionTableViewController.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 7/21/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//

import UIKit


class stepCell : UITableViewCell {
    @IBOutlet weak var stepImage: UIImageView!
    @IBOutlet weak var stepTitle: UILabel!
    var imagePicker = UIImagePickerController()
    
}

class ActionTableViewController: UITableViewController {
    
    var previousVC = MainViewController()
    var selectedTaskAnlaysis = TaskAnalysisCoreData()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTaskAnlaysis.steps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "step", for: indexPath) as! stepCell
        
        cell.stepTitle?.text = selectedTaskAnlaysis.steps[indexPath.row]
        return cell
    }
}
