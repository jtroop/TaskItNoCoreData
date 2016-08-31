//
//  TaskDetailViewController.swift
//  Taskit
//
//  Created by DevStuff on 2016-08-24.
//  Copyright © 2016 DevStuff. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var detailTaskModel: TaskModel!
    var mainVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subTask
        self.dueDatePicker.date = detailTaskModel.date
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        // We have to user the popViewcontrollerAnimated because we used a show 
        // seque to transition between View Controllers and in doing that is put the 
        // new view controller on the ViewController stack
        // So we are just popping off the top element of a stack which in this 
        // case is a ViewController
        
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    // We are just popping the view controller off the stack
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        let task = TaskModel(task: taskTextField.text!, subTask: subtaskTextField.text!, date: dueDatePicker.date, completed: false)
        
        // We are accessing the main view controller which we created at the top of this file
        // mainVC.tableView.indexPathForSelectedRow!.row get index of the path we clicked on to get to the edit page
        // We are also replacing the existing task in the mainVC.tableView with the one we just created above
        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow!.row] = task
        
        // Now we just pop the view controller off the stack
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}
