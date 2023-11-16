//
//  NotificationViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 14/11/23.
//

import UIKit
import MultiSelectSegmentedControl

class NotificationViewController: UIViewController {

    @IBOutlet weak var resumeText: UILabel!
    @IBOutlet weak var hourPicker: UIDatePicker!
    @IBOutlet weak var notifyActive: UISwitch!
    
    private var flowerData: FlowerData?
    var data: FlowerData{
        get{
            return flowerData!
        }
        
        set{
            flowerData = newValue
        }
    }
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    var multiSelect1: MultiSelectSegmentedControl?
    var multiSelect2: MultiSelectSegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelectConstrains()
        customSelectStyle()
        hourPicker.contentHorizontalAlignment = .left
        setData()
        multiSelect1?.delegate = self
        multiSelect2?.delegate = self
    }
    
    private func customSelectStyle(){
        multiSelect1?.tintColor = UIColor(named: "Color 4")
        multiSelect1?.selectedBackgroundColor = UIColor(named: "Color")
        multiSelect1?.backgroundColor = UIColor(named: "Color 4")
        
        
        multiSelect2?.tintColor = UIColor(named: "Color 4")
        multiSelect2?.selectedBackgroundColor = UIColor(named: "Color")
        multiSelect2?.backgroundColor = UIColor(named: "Color 4")
        
        changeTextSelectColor(colorNormal: UIColor(named: "Color 5") ?? UIColor.black, colorSelected: UIColor(named: "Color 5") ?? UIColor.black)
        
    }
    
    private func changeTextSelectColor(colorNormal: UIColor, colorSelected: UIColor){
        multiSelect1?.setTitleTextAttributes([.foregroundColor: colorSelected], for: .selected)
        multiSelect1?.setTitleTextAttributes([.foregroundColor: colorNormal], for: .normal)
        
        multiSelect2?.setTitleTextAttributes([.foregroundColor: colorSelected], for: .selected)
        multiSelect2?.setTitleTextAttributes([.foregroundColor: colorNormal], for: .normal)
    }
    
    
    private func configureSelectConstrains(){
        multiSelect1 = MultiSelectSegmentedControl()
        multiSelect1!.items = ["Mon","Tue","Wen","Thur"]
        view1.addSubview(multiSelect1!)
        multiSelect1?.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        multiSelect1?.leftAnchor.constraint(equalTo: view1.leftAnchor).isActive = true
        multiSelect1?.rightAnchor.constraint(equalTo: view1.rightAnchor).isActive = true
        multiSelect1?.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
        multiSelect1?.translatesAutoresizingMaskIntoConstraints = false
        
        
        multiSelect2 = MultiSelectSegmentedControl()
        multiSelect2!.items = ["Fri","Sat","Sun"]
        view2.addSubview(multiSelect2!)
        multiSelect2?.topAnchor.constraint(equalTo: view2.topAnchor).isActive = true
        multiSelect2?.leftAnchor.constraint(equalTo: view2.leftAnchor).isActive = true
        multiSelect2?.rightAnchor.constraint(equalTo: view2.rightAnchor).isActive = true
        multiSelect2?.bottomAnchor.constraint(equalTo: view2.bottomAnchor).isActive = true
        multiSelect2?.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setData(){
        notifyActive.isOn = data.haveAlarm
        let dateFormatter = DateFormatter(format: "hh:mm a")
        var am = "am"
        if (data.getAM() == 1){
            am = "pm"
        }
        
        if let dateNew = dateFormatter.date(from: "\(data.getHour()):\(data.getMinutes()) \(am)") {
            hourPicker.setDate(dateNew, animated: true)
        }
        
        if(notifyActive.isOn){
            resumeText.text = "Notificaciones activas"
            
        }else{
            resumeText.text = "Notificaciones desactivadas"
        }
        
    }
    
    private func getTextDay(d: Days) -> String{
        switch(d){
            case .MON: return "Lun"
            case .TUE: return "Mar"
            case .WED: return "Mie"
            case .THU: return "Jue"
            case .FRI: return "Vie"
            case .SAT: return "Sab"
            case .SUN: return "Dom"
        }
    }

    @IBAction func activeNotification(_ sender: UISwitch) {
        (sender.isOn) ? (resumeText.text = "Notificaciones activas") : (resumeText.text = "Notificaciones desactivadas")
        
        //Comprobar al menos un dia
        
        //Establecer notificaciones
        
        //Guardar datos
    }
        
    @IBAction func hourPickerChange(_ sender: UIDatePicker) {
        //Desactivar notificaciones
        //Modificar las
    }
    
    
}

extension NotificationViewController: MultiSelectSegmentedControlDelegate{
    func multiSelect(_ multiSelectSegmentedControl: MultiSelectSegmentedControl, didChange value: Bool, at index: Int) {
        
        
        
        
    }
    
    
}
