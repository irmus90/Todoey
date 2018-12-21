//
//  ViewController.swift
//  Todoey
//
//  Created by Irma Ciesielska on 18.12.2018.
//  Copyright © 2018 Irma Ciesielska. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArrey = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "blabla"
        itemArrey.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "blabla"
        itemArrey.append(newItem1)
        
        
        if let items = defaults.array(forKey: "ToDoListArrey") as? [Item] {
            itemArrey = items
        }
    }

// Mark - Tableview Datasource Methodes
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArrey.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArrey[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
    
        return cell
        
    }
    
// MARK - TableView Delagate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      //  print(itemArrey[indexPath.row])
        
        itemArrey[indexPath.row].done = !itemArrey[indexPath.row].done

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
// MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happend when user clicks the Add Item button on our alert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArrey.append(newItem)
            
            self.defaults.set(self.itemArrey, forKey: "ToDoListArrey")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

