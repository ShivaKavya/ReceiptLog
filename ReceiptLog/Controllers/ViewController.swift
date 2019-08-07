//
//  ViewController.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    var allReceiptNames : Results<Receipts>?
 
    @IBOutlet var leftMenuButton: UIBarButtonItem!
    
    @IBOutlet var displayAllReceipts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAllReceipts.reloadData()
        self.title = "All Receipts"
        displayAllReceipts.delegate = self
        displayAllReceipts.dataSource = self
    }
    

    @IBAction func openLoginView(_ sender: UIBarButtonItem) {
        
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allReceiptNames?.count ??  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllReceipts", for: indexPath)
        cell.textLabel?.text = allReceiptNames?[indexPath.row].rName ?? "No Receipts to display"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Newly Added") { (contextualAction, view, boolValue) in
            print("Leading Action style .normal")
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            print("Trailing Action style .destructive")
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
    

}

