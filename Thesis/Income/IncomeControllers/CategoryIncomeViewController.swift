//
//  CategoryIncomeViewController.swift
//  Thesis
//
//  Created by Aleksandr Mayyura on 28.05.2021.
//

import UIKit
import RealmSwift

class CategoryIncomeViewController: UIViewController {
    
    let realm = try! Realm()
    
    var categoty: Results<IncomeCategory>?
    
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        load()
        
    }
    
    //MARK: - Add new Categories

    @IBAction func addCategoryButton(_ sender: Any) {
        
        var textField = UITextField()
        
        let alertVC = UIAlertController(title: "Новая категория", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: .none)
        
        let addAction = UIAlertAction(title: "Сохранить", style: .default) { (addAction) in
            
            let newCategories = IncomeCategory()
            newCategories.name = textField.text!
            
            self.save(category: newCategories)
            
        }
        
        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "Добавьте новую категорию"
            textField = alertTextField
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(addAction)
        present(alertVC, animated: true, completion: nil)
        
    }
    
    //MARK: - save/load methods
    
    func save(category: IncomeCategory){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error save Ctegory, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func load() {
        categoty = realm.objects(IncomeCategory.self)
    }
    
    //MARK: - delegate method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemsIncomeTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedCategory = categoty?[indexPath.row]
        }
    }

}


extension CategoryIncomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    //MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoty?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCategoryCell", for: indexPath) as! CategoryIncomeTableViewCell
        
        cell.textLabel?.text = categoty?[indexPath.row].name ?? "Нет категории"
        
        
        return cell
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToIncomeItems", sender: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
