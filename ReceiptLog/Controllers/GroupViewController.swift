//
//  GroupViewController.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class GroupViewController: UIViewController {

  
    @IBOutlet var receiptGroupTF: UITextField!
   
    @IBOutlet var createGroup: UIButton!
  
    @IBOutlet var backButton: UIButton!
    
    
    let realm = try! Realm()
    
    var groupNames: Results<Groups>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add a Receipt Group"
        // Do any additional setup after loading the view.
        
    }
    
    func saveGroupName()
    {
        if(receiptGroupTF.text == ""){
            
            showAlertWith(title: "Group Name can't be saved", message: "Enter a name")
        }
        else{
            
            let newGroupName = Groups()
            newGroupName.groups = receiptGroupTF.text!
            if let existingGroup = realm.object(ofType: Groups.self, forPrimaryKey: newGroupName.groups){
                showAlertWith(title: "Group Name already Exists", message: "Change Title.")
                print(existingGroup)
            }
            do {
                try realm.write {
                    realm.add(newGroupName)
                 
                    showAlertWith(title: "Data Saved", message: "Your Data has been saved.")
                }
            } catch {
                showAlertWith(title: "Error saving Data", message: error.localizedDescription)
                print("Error saving data \(error)")
            }
        }
        
    }

    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func retrieveGroupNames()
    {
        groupNames = realm.objects(Groups.self)
        print("groupNames", groupNames as Any)
    }
    
    func sendGroupNames()
    {
        let GroupsName = groupNames
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = myStoryBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        nextVC.groupsList = GroupsName
        
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @IBAction func createRecceiptGroup(_ sender: UIButton)
    {
        
        saveGroupName()
        retrieveGroupNames()
    }
    
   
    @IBAction func backToProfile(_ sender: UIButton) {
        
     //   retrieveGroupNames()
        
        
        sendGroupNames()
        
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
