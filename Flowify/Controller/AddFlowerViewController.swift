//
//  AddFlowerViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 25/10/23.
//

import UIKit

class AddFlowerViewController: UIViewController {

    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveOutlet: UIBarButtonItem!
    
    
    var irrigationValue: IRRIGATION = IRRIGATION.LOW
    var lightValue: LIGHT = LIGHT.SUN
    var locationValue: LOCATION = LOCATION.INDOOR
    
    private var addFlowerDelegate: AddFlowerDelegate?
    private var data: FlowerData?
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let d = data {
            addFlowerDelegate?.returnNewElement(newElement: d)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        nameTextField.changeTheme(style: traitCollection.userInterfaceStyle)
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
       data = FlowerData(image: "", name: nameTextField.text ?? "", irrigation: irrigationValue, light: lightValue, location: locationValue, haveAlarm: false)
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
