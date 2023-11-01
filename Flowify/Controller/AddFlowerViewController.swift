//
//  AddFlowerViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 25/10/23.
//

import UIKit
import RealmSwift

class AddFlowerViewController: UIViewController, UINavigationControllerDelegate {

    var realm = try! Realm()
    
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveOutlet: UIBarButtonItem!
    
    @IBOutlet weak var irrigationOutlet: UISegmentedControl!
    @IBOutlet weak var lightOutlet: UISegmentedControl!
    @IBOutlet weak var locationOutlet: UISegmentedControl!
    var picker = UIImagePickerController()
    var id: Int64 = 0
    var hasChangeImage: Bool = false
    
    var irrigationValue: IRRIGATION = IRRIGATION.LOW
    var lightValue: LIGHT = LIGHT.SUN
    var locationValue: LOCATION = LOCATION.INDOOR
    
    private var addFlowerDelegate: AddFlowerDelegate?
    private var data: FlowerData?
    private var isModify: Bool = false
    private var pressCell: IndexPath?
    
    var index: IndexPath {
        get{
            return pressCell!
        }
        
        set{
            pressCell = newValue
        }
    }
    
    var dataSet: FlowerData? {
        get {
            return data!
        }
        
        set {
            data = newValue
        }
    }
    
    var modify: Bool {
        get{
            return isModify
        }
        set{
            isModify = newValue
        }
    }
    
    var delegate: AddFlowerDelegate?{
        get{
            return addFlowerDelegate
        }
        
        set{
            addFlowerDelegate = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = UIColor(named: "Border")?.cgColor
        nameTextField.clipsToBounds = true
        nameTextField.changeTheme(style: traitCollection.userInterfaceStyle)
        
        imageSelected.layer.cornerRadius = 10.0
        imageSelected.clipsToBounds = true

        
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        
        id = Int64(UserDefaults.standard.integer(forKey: "ID"))
        
        if modify {
            print("eeee")
            irrigationOutlet.selectedSegmentIndex = data?.irrigation.rawValue ?? 0
            lightOutlet.selectedSegmentIndex = data?.light.rawValue ?? 0
            locationOutlet.selectedSegmentIndex = data?.location.rawValue ?? 0
            irrigationValue = data?.irrigation ?? IRRIGATION.LOW
            lightValue = data?.light ?? LIGHT.SUN
            locationValue = data?.location ?? LOCATION.OUTSIDE
            imageSelected.image = ImageManager().getImage(name: dataSet?.image ?? "")
            nameTextField.text = dataSet?.name ?? ""
        }
        
        print(ImageManager().documentURL)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UserDefaults.standard.set(id, forKey: "ID")
        
        if let d = data {
            if isModify{
                addFlowerDelegate?.returnModifyData()
            }else{
                addFlowerDelegate?.returnNewElement(newElement: d)
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        nameTextField.changeTheme(style: traitCollection.userInterfaceStyle)
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        var imageURL: String = ""
        
        if hasChangeImage {
            if isModify {
                if dataSet?.image != "" {
                    if (ImageManager().removeImage(name: dataSet?.image ?? "")) {
                        ImageManager().saveImage(image: imageSelected.image, name: "\(dataSet?.image ?? "")")
                    }else{
                        delegate?.returnError(error: "No se ha podido eliminar la imágen")
                    }
                }else{
                    ImageManager().saveImage(image: imageSelected.image, name: "\(id)")
                    do {
                        try realm.write{
                            dataSet?.image = "\(id)"
                        }
                    }catch{
                        addFlowerDelegate?.returnError(error: "Error al guardar la imagen Realm: \(error)")
                    }
                    id += 1
                }
            }else{
                ImageManager().saveImage(image: imageSelected.image, name: "\(id)")
                imageURL = "\(id)"
                id += 1
            }
        }
        
        if !isModify {
            data = FlowerData()
            data?.setData(image: imageURL, name: nameTextField.text ?? "", irrigation_: irrigationValue, light_: lightValue, location_: locationValue, haveAlarm: false)
        }else{
            do {
                try realm.write{
                    dataSet?.name = nameTextField.text ?? ""
                    dataSet?.irrigation = irrigationValue
                    dataSet?.light = lightValue
                    dataSet?.location = locationValue
                }
            }catch{
                addFlowerDelegate?.returnError(error: "Error al guardar datos Realm: \(error)")
            }
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func irrigation(_ sender: UISegmentedControl) {
        irrigationValue = IRRIGATION(rawValue: sender.selectedSegmentIndex) ?? .LOW
    }
    @IBAction func light(_ sender: UISegmentedControl) {
        lightValue = LIGHT(rawValue: sender.selectedSegmentIndex) ?? .SUN
    }
    @IBAction func location(_ sender: UISegmentedControl) {
        locationValue = LOCATION(rawValue: sender.selectedSegmentIndex) ?? .INDOOR
    }
    
    @IBAction func searchImage(_ sender: UIBarButtonItem) {
        present(picker, animated: true)
    }
}

extension AddFlowerViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageSelected.image = userImage
            hasChangeImage = true
        }
        
        self.picker.dismiss(animated: true)
    }
}


extension UITextField{
    
    func changeTheme(style: UIUserInterfaceStyle){
        var color: UIColor = UIColor.clear
        (style == .dark) ? (color = UIColor.white) : (color = UIColor.black)
        
        var colorBackGround: UIColor = UIColor.clear
        (style == .dark) ? (colorBackGround = UIColor(red: 159/255, green: 188/255, blue: 169/255, alpha: 1)) : (colorBackGround = UIColor.white)
        
        self.textColor = color
        self.backgroundColor = colorBackGround
        
        self.attributedPlaceholder = NSTextStorage(string: "Nombre",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
    }
}
