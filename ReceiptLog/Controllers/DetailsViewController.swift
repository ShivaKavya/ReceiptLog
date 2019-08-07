//
//  DetailsViewController.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
 
    let realm = try! Realm()
    
    var selectedGroups : Results<Groups>?
    var selectedGroup: Groups?
    {
        didSet {
            
            
            
        }
    }
    
    var sendingReceiptNames: Results<Receipts>?
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var Name: UILabel!
    
    @IBOutlet var Description: UILabel!
    
    @IBOutlet var Amount: UILabel!
    
    @IBOutlet var receiptNameTF: UITextField!
    
    @IBOutlet var receiptDescriptionTV: UITextView!
    
    @IBOutlet var AmountOnReceipt: UITextField!
   
    @IBOutlet var dateTF: UITextField!
    
    @IBOutlet var snapshot: UIButton!
    
    @IBOutlet var receiptSnapshot: UIImageView!
   
    @IBOutlet var saveButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.receiptDescriptionTV.layer.borderColor = UIColor.lightGray.cgColor
        title = selectedGroup?.groups
        showDate()
       
       
       
        print("selectedgroups:", selectedGroups as Any)
        print("sendingReceiptNames", sendingReceiptNames as Any)
    }
    
    func showDate()
    {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        dateTF.text = formattedDate
        
    }
    
    func saveDetails()
    {
        if(receiptNameTF.text == " " || receiptDescriptionTV.text == " " || dateTF.text == " " || AmountOnReceipt.text == " ")
        {
            showAlertWith(title: "Error", message: "Fill all the details")
        }
        else{
           if let currentGroup = self.selectedGroup{
                do {
                    try self.realm.write {
                        let details = Receipts()
                        details.rName = receiptNameTF.text!
                        details.rDescription = receiptDescriptionTV.text!
                        details.rDate = dateTF.text!
                        details.rAmount = AmountOnReceipt.text!
                      //  realm.add(details)
                        
                      currentGroup.rDetails.append(details)
                    //  showAlertWith(title: "Data Saved", message: "Your Data has been saved.")
                        
                    }
                }
                    
                catch {
                    showAlertWith(title: "Error saving Data", message: error.localizedDescription)
                    print("Error saving data \(error)")
                }
          }
            
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(ac, animated: true, completion: nil)
        ac.view.layoutIfNeeded()
    }
    
    func retrieveReceiptNames()
    {
        sendingReceiptNames = selectedGroup?.rDetails.sorted(byKeyPath: "rName", ascending: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ListViewController
        destinationVC.displayReceiptsOfAGroup = sendingReceiptNames
        
    }
    
    func sendNamesToList()
    {
        retrieveReceiptNames()
        performSegue(withIdentifier: "sendNames", sender: self)
    }
    
    func sendNamesToAllReceipts()
    {
        sendingReceiptNames = realm.objects(Receipts.self)
        
        let sendNameToAR = sendingReceiptNames
        let myStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = myStoryBoard.instantiateViewController(withIdentifier: "displayAll") as! ViewController
        next.allReceiptNames = sendNameToAR
        navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func addReceiptPicture(_ sender: UIButton) {
        
        
        print("Button Tapped")
        
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        image.sourceType = UIImagePickerController.SourceType.camera
        self.present(image, animated: true)
        saveImage()
        
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Image Saved", message: "Your image has been saved to your photos.")
        }
    }
    
    func saveImage()
    {
        guard let selectedImage = receiptSnapshot.image else {
            print("Snapshot not saved!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func saveReceipt(_ sender: UIButton) {
       
        saveDetails()
        sendNamesToList()
    
    }

   
    @IBAction func AllReceipts(_ sender: UIButton) {
        
        sendNamesToAllReceipts()
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    

}
