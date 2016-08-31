//
//  ViewController.swift
//  Taskit
//
//  Created by DevStuff on 2016-08-22.
//  Copyright © 2016 DevStuff. All rights reserved.
//

import UIKit

// By adding the UITableViewDataSource and UITableViewDelegate we are just inheriting from it
// In order to properly set this up we have to add two functions from the UITableViewDataSource class
// func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
// func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var baseArray:[[TaskModel]] = []
    
    // Only called the first time when we load this thing up
    // So if we want to refresh data / do something the next time this View Controller is 
    // displayed we have to override the viewDidAppear function, see below
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date1 = Date.from(2014, month: 05, day: 20)
        let date2 = Date.from(2014, month: 03, day: 2)
        let date3 = Date.from(2014, month: 12, day: 13)
        
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, completed: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Brugers", date: date2, completed: false)
        let task3 = TaskModel(task: "Gym", subTask: "Leg Day", date: date3, completed: false)
        let taskArray = [task1, task2, task3]
        
        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
        self.baseArray = [taskArray, completedArray]
        
        
        // What is going on here?
        // When this is called the functions numberOfRowsInSection and cellForRowAtIndexPath are called 
        // and if there are any changes they will be reflected in the table
        // This doesn't have to be here is can be anywhere in the code
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail"{
            // The reason for the "as" keyword is the segue does not know what type of view controller 
            // is it moving so this tells it the name of the ViewController in this case TaskDetailViewController
            // So we are getting access to the TaskDetailViewController at this point in time
            // Think of this as we are getting early access to the ViewController before is it displayed to the user
            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            
            // index path identifitying the row and section of the selected row
            let indexPath = self.tableView.indexPathForSelectedRow!
            let thisTask = self.baseArray[indexPath.section][indexPath.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
            
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            addTaskVC.mainVC = self
            
            
        }
    }
    
    // Once we have transitioned from another controller back to this one we have to reload the data
    // This does not happen automatically, so the way we do this is via overriding the viewDidAppear function
    // we have to chain this to the superclass in order to allow the animation 
    // once this is done we just call the reloadData() function on the tableView
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

        self.baseArray[0] = self.baseArray[0].sort{
            (taskOne: TaskModel, taskTwo: TaskModel) -> Bool in
            // Comparisoon logic here
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    
    // UITableViewDataSource
    // Required
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseArray[section].count
    }
    
    // UITableViewDataSource
    // Required
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisTask = self.baseArray[indexPath.section][indexPath.row]
        
        // Remember myCell is the uniqie identifier we set inthe storyboard
        let cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = Date.toString(thisTask.date)
        return cell
    }
    
    // UITableViewDelegate
    // Not Required
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    // Delegate function
    // Sets the height for each header in each section
    // In this case its 25 points large
    // but this does not show the information its just setting the header height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // Delegate function
    //  This is the section that set the header title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        } else {
            return "Completed"
        }
    }

    // Delegate function
    // Swipe in tableview and when they press delete the set the task to completed
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        if indexPath.section == 0 {
            let newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
            baseArray[1].append(newTask)
        }
        else {
            let newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
            baseArray[0].append(newTask)
        }
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    

}

