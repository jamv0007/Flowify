//
//  MyFlowersViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 24/10/23.
//

import UIKit
import RealmSwift

class MyFlowersViewController: UIViewController {
    
    var cells: Results<FlowerData>?
    var realm = try! Realm()

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var flowers: UICollectionView!
    private var pressCell: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        flowers.dataSource = self
        flowers.delegate = self
        flowers.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
        changeIconColor()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongTouchCellPress))
        flowers.addGestureRecognizer(longPress)
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
        performSegue(withIdentifier: Constants.segueAddFlower, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueAddFlower {
            if let dest = segue.destination as? AddFlowerViewController {
                dest.delegate = self
            }
        }else if segue.identifier == Constants.segueModifyFlower {
            if let dest = segue.destination as? AddFlowerViewController {
                dest.delegate = self
                    
                if pressCell != nil {
                    
                    //dest.dataSet = self.cells?[pressCell?.row]
                    
                }
            }
        }
    }
    
    
    func save(data: FlowerData){
        do {
            try realm.write(){
                realm.add(data)
            }
            
            flowers.reloadData()
            
        } catch {
            print("Error al guardar Realm: \(error)")
        }
    }
    
    func load(){
        cells = realm.objects(FlowerData.self)
    }
    
    @objc func onLongTouchCellPress(gesture: UILongPressGestureRecognizer){
        
        if gesture.state == .began {
            
            let location = gesture.location(in: self.flowers)
            
            if let indexPath = self.flowers.indexPathForItem(at: location) {
                
                let cell = self.flowers.cellForItem(at: indexPath) as? FlowerViewCell
                
                
                let alertControllerBottomSheet = UIAlertController(title: cell?.nameFlower.text, message: "", preferredStyle: .actionSheet)
                
                let alertAction1 = UIAlertAction(title: "Modificar", style: .default){ (accion) in
                    
                    
                    
                }
                let alertAction2 = UIAlertAction(title: "Eliminar", style: .destructive){ (accion) in
                    
                }
                
                let alertAction = UIAlertAction(title: "Cancelar", style: .cancel)
                alertControllerBottomSheet.addAction(alertAction1)
                alertControllerBottomSheet.addAction(alertAction2)
                alertControllerBottomSheet.addAction(alertAction)
                
                present(alertControllerBottomSheet, animated: true)
            }else{
                print("No se ha podido localizar la celda")
            }
        }
    }
    
}


extension MyFlowersViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = flowers.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? FlowerViewCell
        
        cell?.nameFlower.text = cells?[indexPath.row].name ?? ""
        
        
        let path: String = cells?[indexPath.row].image ?? ""
        var uimage: UIImage?
        (path == "") ? (uimage = UIImage(named: "Image")) : (uimage = ImageManager().getImage(name: path))

        cell?.imageFlower.image = uimage
        
        (!(cells?[indexPath.row].haveAlarm ?? false)) ? (cell?.clock.isHidden = true) : (cell?.clock.isHidden = false)
        
        return cell!
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells?.count ?? 0
    }
    
    
}

extension MyFlowersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
}

extension MyFlowersViewController: AddFlowerDelegate {
    func returnNewElement(newElement: FlowerData) {
        save(data: newElement)
        flowers.reloadData()
    }
    
    
}

