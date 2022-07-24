//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by ahmet on 18.07.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tip1TextField: UITextField!
    @IBOutlet weak var tip2TextField: UITextField!
    @IBOutlet weak var tip3TextField: UITextField!
    
    
    var saveData = ViewController().defaults
    var tipPercentagesChanged = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisKeyboard))
        palceholderChanged()
        view.addGestureRecognizer(tap)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        tipsChanged()
        saveData.set(tipPercentagesChanged, forKey: ViewController.saveKey)
    }
    
    func tipsChanged(){
        tipPercentagesChanged = saveData.array(forKey: ViewController.saveKey) as! [String]
        tipPercentagesChanged[0] = (tip1TextField.text!).isEmpty ? tipPercentagesChanged[0] : tip1TextField.text!
        tipPercentagesChanged[1] = (tip2TextField.text!).isEmpty ? tipPercentagesChanged[1] : tip2TextField.text!
        tipPercentagesChanged[2] = (tip3TextField.text!).isEmpty ? tipPercentagesChanged[2] : tip3TextField.text!      
    }

    @objc func dismisKeyboard(){
        tipsChanged()
        saveData.set(tipPercentagesChanged, forKey: ViewController.saveKey)
        palceholderChanged()
        view.endEditing(true)
    }

    func palceholderChanged (){
        let newArray = saveData.array(forKey: ViewController.saveKey)
        tip1TextField.placeholder = newArray![0] as? String
        tip2TextField.placeholder = newArray![1] as? String
        tip3TextField.placeholder = newArray![2] as? String
    }
}
