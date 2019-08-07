//
//  ProfileViewController.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let realm = try! Realm()
   
    @IBOutlet var addImage: UIButton!
    @IBOutlet var profilePicturePVC: UIImageView!
   
    @IBOutlet var FirstName: UILabel!
  
    @IBOutlet var LastName: UILabel!
   
    @IBOutlet var AccountNumber: UILabel!
   
    @IBOutlet var firstNameTF: UITextField!
  
    @IBOutlet var lastNameTF: UITextField!
    
    @IBOutlet var accountNumberTF: UITextField!
    
    @IBOutlet var back: UIButton!
  //  var image : UIImage 
    var userData: Results<UserData>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create Profile"
        
    }
    
    @IBAction func createNewUser(_ sender: UIButton) {
        if(firstNameTF.text == "" || lastNameTF.text == "" || accountNumberTF.text == "" || profilePicturePVC.image == nil){
            
            showAlertWith(title: "Data can't be saved", message: "Enter all the fields")
            back.isHidden = true
        }
        else{
            let data = UserData()
            data.firstName = firstNameTF.text!
            data.lastName = lastNameTF.text!
            data.bankAccountNumber = accountNumberTF.text!
       
            do {
                try realm.write {
                    realm.add(data)
                    
                        guard let selectedImage = profilePicturePVC.image else {
                            print("Snapshot not saved!")
                            return
                        }
                        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
          
                    showAlertWith(title: "Data Saved", message: "Your Data has been saved.")
                    back.isHidden = false
                }
            } catch {
                showAlertWith(title: "Error saving Data", message: error.localizedDescription)
                print("Error saving data \(error)")
            }
        }
//        let sendPic: UIImage = profilePicturePVC.image!
//        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextVC = myStoryBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
//        nextVC.receivedPicture = sendPic
//
//        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    
    @IBAction func addImageAction(_ sender: UIButton) {
   
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        
        
        let alert = UIAlertController(title: "How do you want to upload your picture?", message: "Choose either of the options", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            
            image.sourceType = UIImagePickerController.SourceType.camera
            self.present(image, animated: true)
            print("You've pressed Camera")
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
            
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(image, animated: true)
            print("You've pressed Photo Library")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("You've pressed cancel")
        }))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            profilePicturePVC.image = image
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Image Saved", message: "Your image has been saved to your photos.")
        }
    }
    
    
    @IBAction func backToLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "login", sender: self)
        let retreivedData = userData,sendPic = profilePicturePVC.image!
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        next.receivedUserData = retreivedData
        next.receivedPicture = sendPic
        
        navigationController?.pushViewController(next, animated: true)
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let sendPic: UIImage = profilePicturePVC.image!
             let destinationVC = segue.destination as! LoginViewController
            destinationVC.receivedPicture = sendPic
        }
    }
   

}
