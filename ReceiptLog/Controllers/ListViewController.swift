//
//  ListViewController.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    let realm = try! Realm()
    
    
    var displayReceiptsOfAGroup: Results<Receipts>?
    
    var selectedGroup: Groups?
        
    {
        didSet {
            
        }
    }
    
  
    @IBOutlet var displayReceiptsInGroup: UITableView!
    
    @IBOutlet var addReceipt: UIButton!
    
    @IBOutlet var deleteReceipt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "List of Receipts"
        self.displayReceiptsInGroup.delegate = self
        self.displayReceiptsInGroup.dataSource = self
        
        print("displayReceiptsOfAGroup:", displayReceiptsOfAGroup as Any)
    }
    
    
    
    @IBAction func addReceiptButton(_ sender: UIButton) {
        
        self.displayReceiptsInGroup.reloadData()
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return displayReceiptsOfAGroup?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receivedReceiptNames", for: indexPath)
        
        cell.textLabel?.text = displayReceiptsOfAGroup?[indexPath.row].rName ?? "No Receipts added yet"
        
        return cell
    }

   
    private func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            
           if let deleteItem = self.displayReceiptsOfAGroup?[indexPath.row]{
                do{
                    try self.realm.write {
                        self.realm.delete(deleteItem)
                    }
                }
                catch{
                    print("Error deleting Item, \(error)")
            }
            }
             
           
        }
    
           
        return [deleteAction]
    }

    
    @IBAction func deleteReceiptButton(_ sender: UIButton) {
        
        
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
