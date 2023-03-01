//
//  DetailsViewController.swift
//  AlisverisList
//
//  Created by İbrahim Duman on 26.02.2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sizeText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var secilenUrunIsmi = ""
    var secilenUrunUUID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if secilenUrunIsmi != ""{
            //Core Data seçilen ürün bilgileini göster
            if let uuidString = secilenUrunUUID?.uuidString{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                fetchRequest.returnsObjectsAsFaults = false
                
                do{
                    let sonuclar = try context.fetch(fetchRequest)
                    if sonuclar.count > 0{
                        for sonuc in sonuclar as! [NSManagedObject]{
                            if let isim = sonuc.value(forKey: "isim") as? String{
                                nameText.text = isim
                            }
                            if let fiyat = sonuc.value(forKey: "fiyat") as? Int{
                                priceText.text = String(fiyat)
                            }
                            if let beden = sonuc.value(forKey: "beden") as? String{
                                sizeText.text = beden
                            }
                            if let gorsel = sonuc.value(forKey: "gorsel") as? Data{
                                let image = UIImage(data: gorsel)
                                imageView.image = image
                            }
                        }
                    }
                }catch{
                    print("Hata")
                }
            }
        }else{
            nameText.text = ""
            priceText.text = ""
            sizeText.text = ""
            
        }
        
        

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
        
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let alisveris = NSEntityDescription.insertNewObject(forEntityName: "Alisveris", into: context)
        
        alisveris.setValue(nameText.text, forKey: "isim")
        alisveris.setValue(sizeText.text, forKey: "beden")
        
        if let fiyat = Int(priceText.text!){
            alisveris.setValue(fiyat, forKey: "fiyat")
        }
        alisveris.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        
        alisveris.setValue(data, forKey: "gorsel")
        do{
            try context.save()
            print("kaydedildi")
        }catch{
            print("hata")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func closeKeyboard(){
        view.endEditing(true)
    }
    
}
