//
//  LoginViewController.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

     let realm = try! Realm()
    
    @IBOutlet var editButton: UIButton!
    
    @IBOutlet var firstName: UILabel!
    
    @IBOutlet var lastName: UILabel!
    
    @IBOutlet var accountNumber: UILabel!
    
    @IBOutlet var ReceiptGroupsHeading: UILabel!
    
    @IBOutlet var profilePictureL: UIImageView!
   
    @IBOutlet var displayReceiptGroups: UITableView!
    
    @IBOutlet var addButtonLVC: UIButton!
    
    @IBOutlet var deleteButtonLVC: UIButton!
    
    var groupsList: Results<Groups>?
    var receivedUserData: Results<UserData>?
    
    var profileDetails: UserData?
    {
        didSet{ }
    }
    
    
    
    var receivedPicture = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Left Menu"
        
        access()
        
         displayReceiptGroups.reloadData()
        
        self.displayReceiptGroups.delegate = self
        self.displayReceiptGroups.dataSource = self
        
        updateUserData()
        
        firstName.text = profileDetails?.firstName
        lastName.text = profileDetails?.lastName
        accountNumber.text = profileDetails?.bankAccountNumber
        
       
        
        print(receivedUserData as Any)
        print("groupsList:", groupsList as Any)
    }
    
    
    
    
    
    
    
    @IBAction func createProfile(_ sender: UIButton) {
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
   
     func access()
     {
        if (firstName.text == "First Name" || lastName.text == "Last Name" || accountNumber.text == "Account Number")
        {
          //  ReceiptGroupsHeading.isHidden = true
           // displayReceiptGroups.isHidden = true
          //  addButtonLVC.isHidden = true
          //  deleteButtonLVC.isHidden = true
        }
        else{
            
            ReceiptGroupsHeading.isHidden = false
           displayReceiptGroups.isHidden = false
            addButtonLVC.isHidden = false
          deleteButtonLVC.isHidden = false
            
        }
    }
    
  
    
    @IBAction func addReceiptGroup(_ sender: UIButton) {
        
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "group") as! GroupViewController
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiptGroups", for: indexPath)
        
        cell.textLabel?.text = groupsList?[indexPath.row].groups ?? "No groups added yet"
        
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "addToGroup", sender: self)
        
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
 
    func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.groupsList?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    func updateUserData()
    {
        receivedUserData = realm.objects(UserData.self)
        
        if(receivedUserData!.count > 0){
            
            self.profileDetails = receivedUserData?[0]
        }
        
    }

    @IBAction func deleteReceiptGroup(_ sender: UIButton) {
        
         profilePictureL.image = receivedPicture
    }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        
        if let indexPath = displayReceiptGroups.indexPathForSelectedRow {
            destinationVC.selectedGroup = groupsList?[indexPath.row]
            
        }
    }
   

}
