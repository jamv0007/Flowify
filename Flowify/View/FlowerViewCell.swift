//
//  FlowerViewCell.swift
//  Flowify
//
//  Created by Jose Antonio on 24/10/23.
//

import UIKit

class FlowerViewCell: UICollectionViewCell {

    @IBOutlet weak var nameFlower: UILabel!
    @IBOutlet weak var imageFlower: UIImageView!
    
    @IBOutlet weak var clock: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
