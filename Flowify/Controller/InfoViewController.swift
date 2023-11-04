//
//  InfoViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 3/11/23.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var IrirgationText: UILabel!
    @IBOutlet weak var lightText: UILabel!
    @IBOutlet weak var locationtext: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var flowerData: FlowerData?
    var data: FlowerData{
        get{
            return flowerData!
        }
        set{
            flowerData = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        
    }
    
    private func setImage(name: String){
        ImageManager().getImage(name: name)
    }
    
    @IBAction func activeRecordatory(_ sender: UIButton) {
    }
}
