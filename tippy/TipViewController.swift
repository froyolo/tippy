//
//  ViewController.swift
//  tippy - Tip Calculator
//
//  Main view for the tip calculator
//
//  Created by Ngan, Naomi on 8/13/17.
//  Copyright © 2017 Ngan, Naomi. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    // Bill amount labels
    @IBOutlet weak var billText: UILabel!
    @IBOutlet weak var billField: UITextField!

    // Tip labels
    @IBOutlet weak var tipText: UILabel!
    @IBOutlet weak var tipField: UILabel!

    // Total labels
    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var totalField: UILabel!
    
    // Horizontal line
    @IBOutlet weak var line: UIView!
    
    // Tip control
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Some view initialization/set-up stuff (only called once in lifecycle)
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Font stuff
        billText.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        tipText.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        totalText.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        billField.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        tipField.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        totalField.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        tipControl.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Helvetica", size: 15)! ], for: .normal)
    }
    
    // Called after viewDidLoad(), and just before the view appears on the screen
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        // Display numbers from the most recent calculation
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipDefault")

        let billDate = defaults.object(forKey: "billDate") as? NSDate
        if billDate != nil { // Check if there was a recent calculation (within 10 minutes)
            let minutesSinceLastCalculation = abs(billDate!.timeIntervalSinceNow)/60.0
            
            if minutesSinceLastCalculation > 10.0 { // Last calculation was too long ago, wipe it
                defaults.removeObject(forKey: "billDate")
                defaults.removeObject(forKey: "tipAmount")
                defaults.removeObject(forKey: "totalAmount")
                defaults.removeObject(forKey: "tipSelected")
                defaults.removeObject(forKey: "billAmount")
                defaults.synchronize() // Make sure updates are saved
            } else { // Use persisted tip amount (instead of default)
                tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipSelected")
            }
        }
        
        // Grab all persisted numbers and show those
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = NSLocale.current
        numberFormatter.numberStyle = .currency
        billField.text = defaults.string(forKey: "billAmount") ?? ""
        tipField.text = numberFormatter.string(from: defaults.double(forKey: "tipAmount") as NSNumber)
        totalField.text = numberFormatter.string(from: defaults.double(forKey: "totalAmount") as NSNumber)
        
        // Make sure the keyboard is always visible and the bill amount is always the first responder
        billField.becomeFirstResponder()
        
        // Animations
        billText.center.y -= self.view.bounds.width
        billField.center.y -= self.view.bounds.width
        tipText.center.y -= self.view.bounds.width
        tipField.center.y -= self.view.bounds.width
        totalText.center.y += self.view.bounds.width
        totalField.center.y += self.view.bounds.width
        self.line.alpha = 0.0
        self.tipControl.alpha = 0.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animations
        UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: {
            self.billText.center.y += self.view.bounds.width
            self.billField.center.y += self.view.bounds.width
            self.tipText.center.y += self.view.bounds.width
            self.tipField.center.y += self.view.bounds.width
            self.line.alpha = 1.0
            self.tipControl.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: [], animations: {
            self.totalText.center.y -= self.view.bounds.width
            self.totalField.center.y -= self.view.bounds.width
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // Tip calculations
    @IBAction func calculateTip(_ sender: Any) {
        
        // Calculate the tip and total based on user inputs
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip  = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Use locale specific currency and currency thousands separator
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = NSLocale.current
        numberFormatter.numberStyle = .currency
        tipField.text = numberFormatter.string(from: tip as NSNumber)
        totalField.text = numberFormatter.string(from: total as NSNumber)
        
        // Remember calculations across app restarts.
        let defaults = UserDefaults.standard
        defaults.set(NSDate(), forKey: "billDate")
        defaults.set(bill, forKey: "billAmount")
        defaults.set(tip, forKey: "tipAmount")
        defaults.set(total, forKey: "totalAmount")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "tipSelected")
        defaults.synchronize()
        
    }
    
    // Preparation before navigation to the Settings view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let controller = segue.destination as! SettingsViewController
        
        // Pass self to the settings view controller
        controller.tipViewController = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hides keyboard on tap
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
}

