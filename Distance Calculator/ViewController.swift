//
//  ViewController.swift
//  Distance Calculator
//
//  Created by Shyam Pindoria on 3/9/17.
//  Copyright © 2017 Shyam Pindoria. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    public static var settings: [String: Int] = ["system": 0, "diameter": 1, "distance": 1]
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var mainLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var revolutionsLabel: UILabel!
    
    @IBOutlet var diameterTextField: UITextField!
    @IBOutlet var rpmTextField: UITextField!
    @IBOutlet var distanceTextField: UITextField!
    
    let gradient = CAGradientLayer()
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //Looks for single or multiple taps.
        let hideKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        self.view.addGestureRecognizer(hideKeyboard)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradient.frame = self.topView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUnits()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Dismiss the keyboard
        self.view.endEditing(true)
        dismissMenu()
    }
    
    func dismissMenu() {
        //Dismiss the menu
        if menuShowing {
            openCloseMenu(self)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
                dismissMenu()
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func initialize() {
        
        //Create the gradient for the topView
        //1st color
        let colorTop = UIColor(red: 230.0 / 255.0, green: 62.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0).cgColor
        //2nd color
        let colorBottom = UIColor(red: 75.0 / 255.0, green: 58.0 / 255.0, blue: 132.0 / 255.0, alpha: 1.0).cgColor
        //Set the colors to the gradient layer
        gradient.colors = [colorTop, colorBottom]
        //x and y coordinates for the gradient
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        //Assign the gradient to the view
        self.topView.layer.insertSublayer(gradient, at: 0)
        self.topView.layer.cornerRadius = 100
        
        self.mainView.layer.shadowOpacity = 1
        self.mainView.layer.shadowRadius = 10
        
    }
    
    func updateUnits() {
        
        if ViewController.settings["system"] == 0 {
        
            if ViewController.settings["diameter"] == 1 {
            diameterTextField.placeholder = "Metres"
                } else {
            diameterTextField.placeholder = "Millimtres"
            }
        
            if ViewController.settings["distance"] == 1 {
                distanceTextField.placeholder = "Metres"
            } else {
                distanceTextField.placeholder = "Millimtres"
            }
            
        } else {
            
            if ViewController.settings["diameter"] == 1 {
                diameterTextField.placeholder = "Feet"
            } else {
                diameterTextField.placeholder = "Inches"
            }
            
            if ViewController.settings["distance"] == 1 {
                distanceTextField.placeholder = "Feet"
            } else {
                distanceTextField.placeholder = "Inches"
            }
            
        }
        
    }
    
    @IBAction func openCloseMenu(_ sender: Any) {
        
        
        if menuShowing {
            self.mainLeadingConstraint.constant = 0
        }
        else {
            self.mainLeadingConstraint.constant = 200
            dismissKeyboard()
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.gradient.frame = self.topView.bounds
        })
        
        menuShowing = !menuShowing
        
        
    }
    
    func getValueFromTextField(textField: UITextField, units: Int) -> Double {
        
        if var value = Double(textField.text!) {
            if ViewController.settings["system"] == 0 {
                if units == 0 {
                    value = value * 0.001
                }
            } else {
                if units == 0 {
                    value = value * 0.0254
                } else {
                    value = value * 0.3048
                }
            }
            return value
        }
        
        return 0
        
    }
    
    @IBAction func calculateDistance(_ sender: UIButton) {
        dismissKeyboard()
        let distance = getValueFromTextField(textField: distanceTextField, units: ViewController.settings["distance"]!)
        let diameter = getValueFromTextField(textField: diameterTextField, units: ViewController.settings["diameter"]!)
        let rpm = Double(rpmTextField.text!)
                    
        let totalTime = distance / (((Double.pi * diameter) / 60) * rpm!)
        let revolutions = rpm! / 60 * totalTime
        timeLabel.text = "\(String(format: "%.2f", totalTime))s"
        
        revolutionsLabel.text = "\(String(format: "%.2f", revolutions)) Revolutions"
    }
    


}

