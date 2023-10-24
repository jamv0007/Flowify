//
//  MyFlowersViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 24/10/23.
//

import UIKit

class MyFlowersViewController: UIViewController {
    
    var cells = [FlowerData(image: "Image", name: "Nuemero1",haveAlarm: false),FlowerData(image: "Image", name: "Nuemero1",haveAlarm: true),FlowerData(image: "Image", name: "Nuemero1",haveAlarm: true)]

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var flowers: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowers.dataSource = self
        flowers.delegate = self
        flowers.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
        changeIconColor()
    }
    
    //MARK: - Al cambiar de modo claro a oscuro o al reves
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
            
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                changeIconColor()
            }
    }
    
    func changeIconColor(){
        if traitCollection.userInterfaceStyle == .light {
            addButton.tintColor = .black
        }else{
            addButton.tintColor = .white
        }
    }
    
    @IBAction func addElement(_ sender: UIBarButtonItem) {
    }
}


extension MyFlowersViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = flowers.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? FlowerViewCell
        
        cell?.nameFlower.text = cells[indexPath.row].name
        cell?.imageFlower.image = UIImage(named: cells[indexPath.row].image)
        (!cells[indexPath.row].haveAlarm) ? (cell?.clock.isHidden = true) : (cell?.clock.isHidden = false)
        
        return cell!
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    
}

extension MyFlowersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

