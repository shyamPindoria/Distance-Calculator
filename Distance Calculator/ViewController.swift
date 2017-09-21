//
//  ViewController.swift
//  Distance Calculator
//
//  Created by Shyam Pindoria on 3/9/17.
//  Copyright © 2017 Shyam Pindoria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Store the measuring systems and units
    public static var settings: [String: Int] = ["system": 0, "diameter": 1, "distance": 1]
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var mainLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var minLabel: UILabel!
    @IBOutlet var secLabel: UILabel!
    @IBOutlet var revolutionsLabel: UILabel!
    
    @IBOutlet var calculateButton: UIButton!
    
    @IBOutlet var diameterTextField: UITextField!
    @IBOutlet var rpmTextField: UITextField!
    @IBOutlet var distanceTextField: UITextField!
    
    let gradient = CAGradientLayer() //Gradient for the top view
    var menuShowing = false //Whether menu is showing or not
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up necessary stuff
        initialize()
        
        //Observers that will call a function when the keyboard pops up or closes
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Looks for taps on a view and calls the dismiss keyboard
        let hideKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        //Add the gesture recogniser to mainView
        self.mainView.addGestureRecognizer(hideKeyboard)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Adjust the gradient sublayer when subviews are updated
        self.gradient.frame = self.topView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Update the units displayed in the textfields
        updateUnits()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Hides the keyboard and the menu
    func dismissKeyboard() {
        //Dismiss the keyboard
        self.view.endEditing(true)
        //Dismiss the menu
        dismissMenu()
    }
    
    ///Hides the menu if showing
    func dismissMenu() {
        //Dismiss the menu
        if menuShowing {
            openCloseMenu(self)
        }
    }
    
    ///Moves the view up when the keyboard shows up
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                //Move the view by the keyboard's height
                self.view.frame.origin.y -= keyboardSize.height
                //Dismiss the menu when the keyboard shows
                dismissMenu()
            }
        }
    }
    
    ///Moves the view back to place once the keyboard is dismissed
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                //Move the view back to place
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    ///Set up of the application is done here
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
        
        //Round the edges of the calculate button
        self.calculateButton.layer.cornerRadius = self.calculateButton.frame.height / 2
        //Give the calculate button some shadow
        self.calculateButton.layer.shadowOpacity = 0.3
        self.calculateButton.layer.shadowRadius = 3
        self.calculateButton.layer.shadowOffset.height = 3
        self.calculateButton.layer.shadowOffset.width = 2
        
        //Let the main view cast a shadow on the menu
        self.mainView.layer.shadowOpacity = 1
        self.mainView.layer.shadowRadius = 10
        
    }
    
    ///Updates the units being displayed in the text field placeholders
    func updateUnits() {
        
        //Metric
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
        //Imperial
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
    
    ///Handles the opening and closing of the side menu
    @IBAction func openCloseMenu(_ sender: Any) {
        
        //First check if the menu is showing to determine whether it needs to be shown or hidden
        if menuShowing {
            //Adjust the constraint to hide the menu
            self.mainLeadingConstraint.constant = 0
        }
        else {
            //Adjust the constraint to show the menu
            self.mainLeadingConstraint.constant = 200
            //Dismiss the keyboard when the menu shows up
            dismissKeyboard()
        }
        
        //Animate the menu giving it a sliding effect
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            //Adjust the gradient back to place
            self.gradient.frame = self.topView.bounds
        })
        
        //Change the status of menuShowing
        menuShowing = !menuShowing
        
        
    }
    
    ///Gets the value from a text field and converts it into metres to make it easier to incorporate the value in the formula
    func getValueFromTextField(textField: UITextField, units: Int) -> Double {
        
        //Check if the value is a number
        if var value = Double(textField.text!) {
            //Check whether the measuring system is imperial or metric
            if ViewController.settings["system"] == 0 {
                //Metric
                if units == 0 {
                    //Millimetres to Metres
                    value = value * 0.001
                }
            } else {
                //Imperial
                if units == 0 {
                    //Inches to Metres
                    value = value * 0.0254
                } else {
                    //Feet to Metres
                    value = value * 0.3048
                }
            }
            return value
        }
        //Return 0 if the value was a string
        return 0
        
    }
    
    ///Calculate the time taken
    @IBAction func calculateTime(_ sender: UIButton) {
        
        //Get the diameter in metres
        let diameter = getValueFromTextField(textField: diameterTextField, units: ViewController.settings["diameter"]!)
        //Get the distance in metres
        let distance = getValueFromTextField(textField: distanceTextField, units: ViewController.settings["distance"]!)
        
        //Check whether the RPM is a number
        if let rpm = (Double(rpmTextField.text!)) {
            //Check whether the input values are not 0
            if diameter != 0 && rpm != 0 && distance != 0 {
                //Calculate the total time in seconds
                var totalTime = distance / (((Double.pi * diameter) / 60) * rpm)
                //Calculate the total revolutions
                let revolutions = rpm / 60 * totalTime
                
                //Round off the total time so that it can be converted into hours, minutes and seconds
                totalTime = round(totalTime)
                
                //Update the hour label
                hourLabel.text = String(format: "%02i", Int(totalTime / 3600))
                //Update the minute label
                minLabel.text = String(format: "%02i", Int(totalTime) / 60 % 60)
                //Update the seconds label
                secLabel.text = String(format: "%02i", Int(totalTime) % 60)
                //Update the revolutions label
                revolutionsLabel.text = "\(String(format: "%.2f", revolutions)) Revolutions"
                
                //Dismiss the keyboard
                dismissKeyboard()
            }
        }
    }
    


}

