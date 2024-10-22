//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Virgi Septian on 18/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    
    var categories: Results<Category>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    //MARK: - Table View Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemcell", for: indexPath)
        
        let item = categories[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let IndexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[IndexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        
        
        tableView.reloadData()
    }
    
    //MARK: - Add New Category
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
