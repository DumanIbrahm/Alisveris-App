//
//  DetailsViewController.swift
//  AlisverisList
//
//  Created by İbrahim Duman on 26.02.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var sizeText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
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
