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
    
    var settings: [String: Int] = ["system": 0, "diameter": 1, "distance": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUnits()
    }
    
    @IBAction func settingsChanged(_ sender: UISegmentedControl) {
        
        self.settings.updateValue(measuringSystem.selectedSegmentIndex, forKey: "system")
        
        self.settings.updateValue(diameter.selectedSegmentIndex, forKey: "diameter")
        
        self.settings.updateValue(distance.selectedSegmentIndex, forKey: "distance")
        
       self.updateUnits()
        
    }
    
    func updateUnits() {
        
        if(settings["system"] == 1) {
            
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
        
        measuringSystem.selectedSegmentIndex = settings["system"]!
        diameter.selectedSegmentIndex = settings["diameter"]!
        distance.selectedSegmentIndex = settings["distance"]!
    
    }
}
