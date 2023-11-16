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

    let blackColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    let whiteColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
    let backgroundColorLight = CGColor(red: 0.722, green: 0.482, blue: 0.573, alpha: 1)
    let backgroundColorDark = CGColor(red: 0.667, green: 0.310, blue: 0.447, alpha: 1)
    
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
        setData()
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        
        (traitCollection.userInterfaceStyle == .light) ? addTable(color: blackColor,back: backgroundColorLight) : addTable(color: whiteColor,back: backgroundColorDark)
        
        IrirgationText.borderRadius(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], amount: 10)
        locationtext.borderRadius(corners: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner], amount: 10)

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        (traitCollection.userInterfaceStyle == .light) ? addTable(color: blackColor,back: backgroundColorLight) : addTable(color: whiteColor,back: backgroundColorDark)
    }
    
    private func addTable(color: CGColor, back: CGColor){
        IrirgationText.addBorder(size: 1,color: color)
        lightText.addBorder(size: 1,color: color)
        locationtext.addBorder(size: 1,color: color)
        
        IrirgationText.setBackgroundColor(color: back)
        locationtext.setBackgroundColor(color: back)
        lightText.setBackgroundColor(color: back)
        
    }
    
    private func setData(){
        setImage(name: data.image)
        nameText.text = data.name
        IrirgationText.text = "Riego: \(getIrrigationText())"
        lightText.text = "Luz: \(getLightText())"
        locationtext.text = "Localizacion: \(getLocationText())"
    }
    
    private func getIrrigationText() -> String {
        switch data.irrigation {
            case .LOW: return "Bajo"
            case .MODERATE: return "Moderado"
            case .HIGH: return "Alto"
        }
    }
    
    private func getLightText() -> String {
        switch data.light {
            case .NOT_DIRECTED: return "Luz no directa del sol"
            case .SUN: return "Luz solar"
        }
    }
    
    private func getLocationText() -> String {
        switch data.location {
        case .INDOOR: return "Interior"
        case .OUTSIDE: return "Exterior"
        case .BOTH: return "Interior o exterior"
        }
    }
    
    private func setImage(name: String){
        imageView.image = ImageManager().getImage(name: name)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueAlert {
            let dest = segue.destination as? NotificationViewController
            dest?.data = self.data
        }
    }
    
    @IBAction func notificationButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.segueAlert, sender: self)
    }
    
    
    
}

extension UILabel{

    func setBorderColor(color: CGColor){
        self.layer.borderColor = color
    }
    
    func setBackgroundColor(color: CGColor){
        self.layer.backgroundColor = color
    }

    func addBorder(size: CGFloat,color: CGColor){
        self.layer.borderWidth = size
        self.layer.borderColor = color
    }
    
    func borderRadius(corners: CACornerMask,amount: CGFloat){
        self.layer.cornerRadius = amount
        self.layer.maskedCorners = corners
    }
}
