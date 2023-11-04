//
//  ShowDataViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 22/10/23.
//

import UIKit
import SDWebImage

class ShowDataViewController: UIViewController {

    @IBOutlet weak var nameFlower: UILabel!
    @IBOutlet weak var descriptionFlower: UILabel!
    @IBOutlet weak var imageFlower: UIImageView!
    
    var data: WikiDataAccess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageFlower.layer.cornerRadius = 10.0
        imageFlower.clipsToBounds = true
        
        if let currentData = data {
            nameFlower.text = currentData.title
            descriptionFlower.text = currentData.text
            imageFlower.sd_setImage(with: URL(string: data?.image ?? ""))
        }
        

    }
    
}
