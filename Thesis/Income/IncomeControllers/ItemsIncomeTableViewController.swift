//
//  ItemsIncomeTableViewController.swift
//  Thesis
//
//  Created by Aleksandr Mayyura on 28.05.2021.
//

import UIKit
import RealmSwift

class ItemsIncomeTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var items: Results<IncomeItems>?
    
    var selectedCategory: IncomeCategory? {
        didSet {
             load()
        }
    }
    
      
    
        override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - load methode
    
    func load() {
        
        items = selectedCategory?.items.sorted(byKeyPath: "item", ascending: true)
    }
    
    
    // MARK: - Add new items
    
    @IBAction func addNewAction(_ sender: Any) {
        
        var textField = UITextField()
        var textFieldIncom = UITextField()
        
        let alertVC = UIAlertController(title: "Добавьте новый расход", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Закрыть ", style: .cancel, handler: .none)
        
        let addAction = UIAlertAction(title: " Сохранить", style: .default) { (addAction) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = IncomeItems()
                        newItem.item = textField.text!
                        newItem.income = Int(textFieldIncom.text!)!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error add new item, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "Введите сумму"
            textFieldIncom = alertTextField
        }
        
        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "Добавьте доход"
            textField = alertTextField
            
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(addAction)
        present(alertVC, animated: true, completion: nil)
        
    }
    
    // MARK: - Tableview data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsIncomeCell", for: indexPath) as! ItemsIncomTableViewCell
        
        cell.textLabel?.text = items?[indexPath.row].item ?? "Нет доходов"
        cell.ItemsIncomTextLabel.text = "\(items?[indexPath.row].income ?? 0)"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

   
}
