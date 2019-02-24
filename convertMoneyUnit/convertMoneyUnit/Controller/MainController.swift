//
//  ViewController.swift
//  convertMoneyUnit
//
//  Created by Minh Mon on 2/24/19.
//  Copyright © 2019 Minh Mon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class MainController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moneyUnit.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moneyUnit[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == self.moneyPicker) {
            img.image = UIImage(named: "\(moneyUnitImage[row]).png")
        } else if (pickerView == self.moneyPicker1) {
            img1.image = UIImage(named: "\(moneyUnitImage[row]).png")
        }
    }
    
    @IBOutlet weak var from: UITextField!
    @IBOutlet weak var to: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var moneyPicker: UIPickerView!
    @IBOutlet weak var moneyPicker1: UIPickerView!
    
    
    let moneyUnit = ["USD", "EUR", "VND", "JPY"]
    
    let moneyUnitImage = ["1.png", "2.png", "3.png", "4.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage(named: "1.png")
        moneyPicker.selectRow(0, inComponent: 0, animated: true)
        img1.image = UIImage(named: "3.png")
        moneyPicker1.selectRow(2, inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
       
        Alamofire.request("http://data.fixer.io/api/latest?access_key=13bf9968ef4cd4f861340b5f99206c3c").responseJSON { (response) in
            
            switch (response.result) {
                
            case .success(let data):
                let jsonData = JSON(data)
                let eur = Double(self.from.text!)!/jsonData["rates"][self.moneyUnit[self.moneyPicker.selectedRow(inComponent: 0)]].doubleValue
                let result = eur*jsonData["rates"][self.moneyUnit[self.moneyPicker1.selectedRow(inComponent: 0)]].doubleValue
                self.to.text = String(ceil(result))
            case .failure(let error):
                print(error)
            }
        }
    }

   
    @IBAction func btnConvert_clicked(_ sender: Any) {
        self.getData()
    }
}

