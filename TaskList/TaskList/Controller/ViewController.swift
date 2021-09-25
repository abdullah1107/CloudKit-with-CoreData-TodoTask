//  ViewController.swift
//  TaskList
//  Created by Muhammad Abdullah Al Mamun on 25/9/21.


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let taskManager:TasklistManager = TasklistManager()
    var tasksList:[TaskModel]? = nil
    
    var enteredTask = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextField.delegate = self
        addButton.layer.cornerRadius = 4
        taskTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 10)
        loadListfromServer()
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addNewTask()
    }
    
    private func addNewTask() {
        self.enteredTask = taskTextField.text!.capitalizingFirstLetter()
        //saveTask(named: self.enteredTask)
        
        let taskData = TaskModel(id: UUID(), taskName: self.enteredTask, taskType: "Home")
        taskManager.createTask(task: taskData)
        
        DispatchQueue.main.async {
            self.loadListfromServer()
            self.tableView.reloadData()
        }
       
        
        taskTextField.text = ""
    }
    
    func loadListfromServer(){
        
        tasksList = taskManager.fetchTask()
        if(tasksList != nil && tasksList?.count != 0)
        {
            self.tableView.reloadData()
        }
        
    }
    
    
    
    
    


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "taskCell")
        
        guard let taskName = self.tasksList?[indexPath.row].taskName else {return UITableViewCell()}
        cell.textLabel?.text = "- " + taskName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            
            //self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            let temp = self.taskManager.deleteTask(id: (self.tasksList?[indexPath.row].id)!)
           // print(temp)


            tasksList = taskManager.fetchTask()
            if(tasksList != nil && tasksList?.count != 0)
            {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               
            }

            if temp{
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            


        } else if editingStyle == .insert {
            
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskTextField.resignFirstResponder()
        addNewTask()
        return true
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


