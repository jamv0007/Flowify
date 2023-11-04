//
//  AddFlowerViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 25/10/23.
//

import UIKit
import RealmSwift

class AddFlowerViewController: UIViewController, UINavigationControllerDelegate {

    private var realm = try! Realm()
    
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveOutlet: UIBarButtonItem!
    
    @IBOutlet weak var irrigationOutlet: UISegmentedControl!
    @IBOutlet weak var lightOutlet: UISegmentedControl!
    @IBOutlet weak var locationOutlet: UISegmentedControl!
    
    private var picker = UIImagePickerController()
    private var id: Int64 = 0
    private var hasChangeImage: Bool = false
    private var hasImage: Bool = false
    
    private var irrigationValue: IRRIGATION = IRRIGATION.LOW
    private var lightValue: LIGHT = LIGHT.SUN
    private var locationValue: LOCATION = LOCATION.INDOOR
    
    private var addFlowerDelegate: AddFlowerDelegate?
    private var data: FlowerData?
    private var isModify: Bool = false
    private var pressCell: IndexPath?
    
    var index: IndexPath? {
        get{
            return pressCell ?? nil
        }
        
        set{
            pressCell = newValue
        }
    }
    
    var dataSet: FlowerData? {
        get {
            return data ?? nil
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
            return addFlowerDelegate ?? nil
        }
        
        set{
            addFlowerDelegate = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.changeAparence()
        
        hasImage = false
        
        imageSelected.layer.cornerRadius = 10.0
        imageSelected.clipsToBounds = true

        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        
        id = Int64(UserDefaults.standard.integer(forKey: "ID"))
        
        if modify {
            changeToModify()
        }
        
        print(ImageManager().documentURL)
        
    }
    
    private func changeToModify(){
        irrigationOutlet.selectedSegmentIndex = data?.irrigation.rawValue ?? 0
        lightOutlet.selectedSegmentIndex = data?.light.rawValue ?? 0
        locationOutlet.selectedSegmentIndex = data?.location.rawValue ?? 0
        irrigationValue = data?.irrigation ?? IRRIGATION.LOW
        lightValue = data?.light ?? LIGHT.SUN
        locationValue = data?.location ?? LOCATION.OUTSIDE
        nameTextField.text = dataSet?.name ?? ""
        
        if dataSet?.image != "" {
            imageSelected.image = ImageManager().getImage(name: dataSet?.image ?? "")
            hasImage = true
        }else{
            imageSelected.image = UIImage(named: "Image 2")
            hasImage = false
        }
        
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
        
        //Si se ha cambiado la imágen se hace algo
        if hasChangeImage {
            if hasImage {
               //Borrar y copiar
                //Tiene que haber modificado uno ya guardado
                if let dataSave = data {
                    if (!ImageManager().replaceImage(name: dataSave.image, image: imageSelected.image)) {
                        delegate?.returnError(error: "No se ha podido modificar la imágen")
                    }
                    
                    
                }
            }else{
                //Copiar y Guardar nombre
                //Pueden modificar o no
                ImageManager().saveImage(image: imageSelected.image, name: "\(id)")
                imageURL = "\(id)"
                id += 1
                
                
            }
        }
        
        if modify {
            sendDataBackModifyData(imageURL: imageURL)
        }else {
            sendDataBackNew(imageURL: imageURL)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sendDataBackModifyData(imageURL: String){
        do {
            try realm.write{
                dataSet?.name = nameTextField.text ?? ""
                dataSet?.irrigation = irrigationValue
                dataSet?.light = lightValue
                dataSet?.location = locationValue
                if dataSet?.image == "" && imageURL != ""{
                    dataSet?.image = imageURL
                }
                
            }
        }catch{
            delegate?.returnError(error: "Error al guardar datos Realm: \(error)")
        }
    }
    
    private func sendDataBackNew(imageURL: String){
        data = FlowerData()
        data?.setData(image: imageURL, name: nameTextField.text ?? "", irrigation_: irrigationValue, light_: lightValue, location_: locationValue, haveAlarm: false)
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
    
    func changeAparence(){
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(named: "Border")?.cgColor
        self.clipsToBounds = true
        self.changeTheme(style: traitCollection.userInterfaceStyle)
    }
    
    func changeTheme(style: UIUserInterfaceStyle){
        var color: UIColor = UIColor.clear
        (style == .dark) ? (color = UIColor.white) : (color = UIColor.black)
        
        var colorBackGround: UIColor = UIColor.clear
        (style == .dark) ? (colorBackGround = UIColor(red: 110/255, green: 140/255, blue: 123/255, alpha: 1)) : (colorBackGround = UIColor.white)
        
        self.textColor = color
        self.backgroundColor = colorBackGround
        
        self.attributedPlaceholder = NSTextStorage(string: "Nombre",attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color 3")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
    }
}
