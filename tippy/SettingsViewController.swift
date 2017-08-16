//
//  SettingsViewController.swift
//  tippy - Tip Calculator
//
//  Setting screen allows default tip percentage configuration
//
//  Created by Ngan, Naomi on 8/13/17.
//  Copyright © 2017 Ngan, Naomi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // Default view label
    @IBOutlet weak var defaultLabel: UILabel!
    
    // Tip control
    @IBOutlet weak var tipControl: UISegmentedControl!

    // Tip View Controller (used for fade)
    weak var tipViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Font stuff
        defaultLabel.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        tipControl.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Helvetica", size: 15)! ], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Grab the persisted tip default
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipDefault")
        
        // Dark color theme and light text
        self.view.backgroundColor = UIColor.darkGray
        self.defaultLabel.textColor = UIColor.white
        self.tipControl.tintColor = UIColor.white

        // Animations
        self.tipControl.alpha = 0.0
        defaultLabel.center.y -= self.view.bounds.width

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animations
        UIView.animate(withDuration: 1.0, delay: 0.3, options: [], animations: {
            self.defaultLabel.center.y += self.view.bounds.width
            self.tipControl.alpha = 1.0
        }, completion: nil)
        
    }
    
    // Called just before the view disappears from the screen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Fades in Tip View, fades out Settings View
        self.tipViewController.view.alpha = 0
        self.view.alpha = 1
        UIView.animate(withDuration: 1.0, animations: {
            // This causes first view to fade in and second view to fade out
            self.tipViewController.view.alpha = 1
            self.view.alpha = 0
        })
    }
    
    // Persists default tip percentage
    @IBAction func saveTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(tipControl.selectedSegmentIndex, forKey: "tipDefault")
        defaults.synchronize() // Make sure updates are saved
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
