//
//  ViewController.swift
//  Tip Calculator
//
//  Created by ahmet on 12.07.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    
    
    var numberOfPeople = 1.0
    var tip: Double = 0.0
    var bill: Double = 0.0
    
    let defaults = UserDefaults.standard
    static let saveKey = "tipsArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisKeyboard))
        view.addGestureRecognizer(tap)

    }

    override func viewWillAppear(_ animated: Bool) {
        if defaults.array(forKey: ViewController.saveKey) == nil {
            defaults.set(["0","10","20"], forKey: ViewController.saveKey)
        }
        tipControlChanged()
    }
    
    @IBAction func splitStepperPressed(_ sender: UIStepper) {
        sender.minimumValue = 1
        sender.maximumValue = 25
        numberOfPeople = sender.value
        splitLabel.text = String(format: "%.0f", numberOfPeople)
        
    }
    @IBAction func calculateTip(_ sender: Any)  {
        calculate()
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
      calculate()
        }
    
    func calculate () {
        let tipPercentages = defaults.array(forKey: ViewController.saveKey) as! [String]
        let tipValue = Double(tipPercentages[tipControl.selectedSegmentIndex])
        
        bill = Double(billAmountTextField.text!.replacingOccurrences(of: ",", with: ".")) ?? 0
        tip = bill * (tipValue! / 100)
        let total = bill + tip
        tipAmountLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
        let totalPerPerson = total / numberOfPeople
        totalPerPersonLabel.text = String(format: "%.2f",ceil(totalPerPerson*100)/100)
        view.endEditing(true)
    }
    
    func tipControlChanged () {
        let newArray = defaults.array(forKey: ViewController.saveKey)!
        tipControl.setTitle("\(newArray[0] as! String) %", forSegmentAt: 0)
        tipControl.setTitle("\(newArray[1] as! String) %", forSegmentAt: 1)
        tipControl.setTitle("\(newArray[2] as! String) %", forSegmentAt: 2)
    }
    
    @objc func dismisKeyboard(){
        view.endEditing(true)
    }
}

