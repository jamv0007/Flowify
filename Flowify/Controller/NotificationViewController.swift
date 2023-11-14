//
//  NotificationViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 14/11/23.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var resumeText: UILabel!
    @IBOutlet weak var hourPicker: UIDatePicker!
    @IBOutlet weak var daySelect2: UISegmentedControl!
    @IBOutlet weak var daySelect1: UISegmentedControl!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourPicker.contentHorizontalAlignment = .left
        setData()
    }
    
    private func setData(){
        notifyActive.isOn = data.haveAlarm
    }

    @IBAction func activeNotification(_ sender: UISwitch) {
    }
    
    @IBAction func daySelected1Change(_ sender: UISegmentedControl) {
    }
    
    @IBAction func daySelected2Change(_ sender: UISegmentedControl) {
    }
    
    @IBAction func hourPickerChange(_ sender: UIDatePicker) {
    }
}
