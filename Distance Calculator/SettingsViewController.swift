//
//  SettingsViewController.swift
//  Distance Calculator
//
//  Created by Shyam Pindoria on 19/9/17.
//  Copyright © 2017 Shyam Pindoria. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var measuringSystem: UISegmentedControl!
    @IBOutlet var diameter: UISegmentedControl!
    @IBOutlet var distance: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUnits()
    }
    
    
    @IBAction func settingsChanged(_ sender: UISegmentedControl) {
        
        ViewController.settings.updateValue(measuringSystem.selectedSegmentIndex, forKey: "system")
        
        ViewController.settings.updateValue(diameter.selectedSegmentIndex, forKey: "diameter")
        
        ViewController.settings.updateValue(distance.selectedSegmentIndex, forKey: "distance")
        
       self.updateUnits()
        
    }
    
    func updateUnits() {
        
        if ViewController.settings["system"] == 1  {
            
            diameter.setTitle("Inch", forSegmentAt: 0)
            diameter.setTitle("Feet", forSegmentAt: 1)
            
            distance.setTitle("Inch", forSegmentAt: 0)
            distance.setTitle("Feet", forSegmentAt: 1)
            
            
        } else {
            diameter.setTitle("Millimetres", forSegmentAt: 0)
            diameter.setTitle("Metres", forSegmentAt: 1)
            
            distance.setTitle("Millimetres", forSegmentAt: 0)
            distance.setTitle("Metres", forSegmentAt: 1)
        }
        
        measuringSystem.selectedSegmentIndex = ViewController.settings["system"]!
        diameter.selectedSegmentIndex = ViewController.settings["diameter"]!
        distance.selectedSegmentIndex = ViewController.settings["distance"]!
    
    }
    
}
