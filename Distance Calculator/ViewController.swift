//
//  ViewController.swift
//  Distance Calculator
//
//  Created by Shyam Pindoria on 3/9/17.
//  Copyright © 2017 Shyam Pindoria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var mainView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var mainLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var diameter: UITextField!
    @IBOutlet var rpm: UITextField!
    @IBOutlet var distance: UITextField!

    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        initialize()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissView))
        mainView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissView() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        openMenu(sender: mainView)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.mainView.frame.origin.y == 0{
                self.mainView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.mainView.frame.origin.y != 0{
                self.mainView.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func initialize() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Creates the gradient for the view
        let gradient: CAGradientLayer = CAGradientLayer()
        //1st color
        let colorTop = UIColor(red: 230.0 / 255.0, green: 62.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0).cgColor
        //2nd color
        let colorBottom = UIColor(red: 75.0 / 255.0, green: 58.0 / 255.0, blue: 132.0 / 255.0, alpha: 1.0).cgColor
        //Set the colors to the gradient layer
        gradient.colors = [colorTop, colorBottom]
        //x and y coordinates for the gradient
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.8, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.height, height: self.topView.frame.size.height)
        //Assign the gradient to the view
        self.topView.layer.insertSublayer(gradient, at: 0)
        
        self.mainView.layer.shadowOpacity = 1
        self.mainView.layer.shadowRadius = 10
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.topView.frame
        rectShape.position = self.topView.center
        rectShape.path = UIBezierPath(roundedRect: self.topView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 100, height: 20)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        self.topView.layer.mask = rectShape
        
    }
    
    @IBAction func openMenu(_ sender: Any) {
        if (menuShowing){
            self.mainLeadingConstraint.constant = 0
        }
        else {
            self.mainLeadingConstraint.constant = 200
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    
    @IBAction func calculateDistance(_ sender: UIButton) {
        timeLabel.text = String(Double(distance.text!)! / (((Double.pi * Double(diameter.text!)!) / 60) * Double(rpm.text!)!))
    }
    


}

