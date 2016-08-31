//
//  AddTaskViewController.swift
//  Taskit
//
//  Created by DevStuff on 2016-08-25.
//  Copyright © 2016 DevStuff. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    // This allows us to pass a view controller to this controller
    // and access all of the passed view controllers pubic properties 
    // methods etc....
    var mainVC: ViewController!
    
    
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    @IBAction func addTaskButtonTapped(sender: UIButton) {
        // We are adding a task via tapping the button
        // We are setting the TaskModel.swift struct variables, note we have to unwrap the task and subtask variables
        // because there is the possibility that they may be nil
        let task = TaskModel(task: taskTextField.text!, subTask: subtaskTextField.text!, date: dueDatePicker.date, completed: false)
        
        // Remember this is passed to this controller when we transistion from the mainVC to this controller
        mainVC?.baseArray[0].append(task)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
